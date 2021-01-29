//  Copyright (c) 2011-present, Facebook, Inc.  All rights reserved.
//  This source code is licensed under both the GPLv2 (found in the
//  COPYING file in the root directory) and Apache 2.0 License
//  (found in the LICENSE.Apache file in the root directory).
//
// Copyright (c) 2011 The LevelDB Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file. See the AUTHORS file for names of contributors.
#pragma once

#include <atomic>
#include <deque>
#include <limits>
#include <memory>
#include <set>
#include <string>
#include <utility>
#include <vector>

#include "db/version_set.h"
#include "options/db_options.h"
#include "port/port.h"
#include "rocksdb/env.h"
#include "rocksdb/status.h"
#include "rocksdb/transaction_log.h"
#include "rocksdb/types.h"

#include "rocksdb/terark_namespace.h"
namespace TERARKDB_NAMESPACE {

#ifndef ROCKSDB_LITE
class WalManager {
 public:
  WalManager(const ImmutableDBOptions& db_options,
             const EnvOptions& env_options, const bool seq_per_batch = false)
      : db_options_(db_options),
        env_options_(env_options),
        env_(db_options.env),
        purge_wal_files_last_run_{0},
        purge_wal_files_running_{false},
        seq_per_batch_(seq_per_batch),
        guard_seqno_{SequenceNumber(-1)} {}

  void AddLogNumber(const uint64_t number);

  uint64_t GetNextLogNumber(const uint64_t number);

  Status GetSortedWalFiles(VectorLogPtr& files, bool allow_empty = false);

  Status GetUpdatesSince(
      SequenceNumber seq_number, std::unique_ptr<TransactionLogIterator>* iter,
      const TransactionLogIterator::ReadOptions& read_options,
      VersionSet* version_set);

  void PurgeObsoleteWALFiles();

  void ArchiveWALFile(const std::string& fname, uint64_t number);

  Status DeleteFile(const std::string& fname, uint64_t number);

  Status TEST_ReadFirstRecord(const WalFileType type, const uint64_t number,
                              SequenceNumber* sequence) {
    return ReadFirstRecord(type, number, sequence);
  }

  Status TEST_ReadFirstLine(const std::string& fname, const uint64_t number,
                            SequenceNumber* sequence) {
    return ReadFirstLine(fname, number, sequence);
  }

  void SetGuardSeqno(SequenceNumber guard_seqno) {
    guard_seqno_.store(guard_seqno, std::memory_order_relaxed);
  }

 private:
  Status GetWalsOfType(const std::string& path, VectorLogPtr& log_files,
                       WalFileType type, bool allow_empty);
  // Requires: all_logs should be sorted with earliest log file first
  // Retains all log files in all_logs which contain updates with seq no.
  // Greater Than or Equal to the requested SequenceNumber.
  Status RetainProbableWalFiles(VectorLogPtr& all_logs,
                                const SequenceNumber target,
                                VersionSet* version_set);

  Status ReadFirstRecord(const WalFileType type, const uint64_t number,
                         SequenceNumber* sequence);

  Status ReadFirstLine(const std::string& fname, const uint64_t number,
                       SequenceNumber* sequence);

  void PurgeObsoleteWALFilesImpl(uint64_t now_seconds);

  // ------- state from DBImpl ------
  const ImmutableDBOptions& db_options_;
  const EnvOptions& env_options_;
  Env* env_;

  // ------- WalManager state -------
  // cache for ReadFirstRecord() calls
  std::unordered_map<uint64_t, SequenceNumber> read_first_record_cache_;
  std::set<uint64_t> log_numbers_;
  port::Mutex read_first_record_cache_mutex_;

  // last time when PurgeObsoleteWALFiles ran.
  std::atomic<uint64_t> purge_wal_files_last_run_;
  std::atomic<bool> purge_wal_files_running_;
  bool seq_per_batch_;

  // obsolete files will be deleted every this seconds if ttl deletion is
  // enabled and archive size_limit is disabled.
  static const uint64_t kDefaultIntervalToDeleteObsoleteWAL = 30;

  std::atomic<SequenceNumber> guard_seqno_;
};

#endif  // ROCKSDB_LITE
}  // namespace TERARKDB_NAMESPACE
