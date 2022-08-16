# REQUIRE: ProjectRootPath/build
rm -r tmp
./db_bench --benchmarks="fillseq,stats" --statistics --blob_size=1024 \
 --value_size=16000 --db=./tmp --num=100000 --disable_auto_compactions=true
 
./db_bench --benchmarks="readrandom" --statistics --blob_size=1024 \
 --db=./tmp --use_existing_db=true \
 --use_direct_reads=true --mmap_read=false \
 --cache_index_and_filter_blocks=true \
 --disable_auto_compactions=true \
 --value_size=16000  --num=100000 --cache_size=16000000 --duration=0

# data_size = 16k * 100K = 1.6G
# cache_size = 16M
# default settings!

# readrandom   :     263.263 micros/op 3798 ops/sec;   58.0 MB/s (100000 of 100000 found)

# STATISTICS:
# rocksdb.block.cache.miss COUNT : 142645
# rocksdb.block.cache.hit COUNT : 157386
# rocksdb.block.cache.add COUNT : 142645
# rocksdb.block.cache.add.failures COUNT : 0
# rocksdb.block.cache.index.miss COUNT : 2035
# rocksdb.block.cache.index.hit COUNT : 97996
# rocksdb.block.cache.index.add COUNT : 22342
# rocksdb.block.cache.index.bytes.insert COUNT : 2666946272
# rocksdb.block.cache.index.bytes.evict COUNT : 2664328976
# rocksdb.block.cache.filter.miss COUNT : 0
# rocksdb.block.cache.filter.hit COUNT : 0
# rocksdb.block.cache.filter.add COUNT : 0
# rocksdb.block.cache.filter.bytes.insert COUNT : 0
# rocksdb.block.cache.filter.bytes.evict COUNT : 0
# rocksdb.block.cache.data.miss COUNT : 140610
# rocksdb.block.cache.data.hit COUNT : 59390
# rocksdb.block.cache.data.add COUNT : 140610
# rocksdb.block.cache.data.bytes.insert COUNT : 1807961280
# rocksdb.block.cache.bytes.read COUNT : 356944896
# rocksdb.block.cache.bytes.write COUNT : 1810304240
# rocksdb.bloom.filter.useful COUNT : 0
# rocksdb.bloom.filter.full.positive COUNT : 0
# rocksdb.bloom.filter.full.true.positive COUNT : 0
# rocksdb.persistent.cache.hit COUNT : 0
# rocksdb.persistent.cache.miss COUNT : 0
# rocksdb.sim.block.cache.hit COUNT : 0
# rocksdb.sim.block.cache.miss COUNT : 0
# rocksdb.memtable.hit COUNT : 0
# rocksdb.memtable.miss COUNT : 100000
# rocksdb.l0.hit COUNT : 100000
# rocksdb.l1.hit COUNT : 0
# rocksdb.l2andup.hit COUNT : 0
# rocksdb.compaction.key.drop.new COUNT : 0
# rocksdb.compaction.key.drop.obsolete COUNT : 0
# rocksdb.compaction.key.drop.range_del COUNT : 0
# rocksdb.compaction.key.drop.user COUNT : 0
# rocksdb.compaction.range_del.drop.obsolete COUNT : 0
# rocksdb.compaction.optimized.del.drop.obsolete COUNT : 0
# rocksdb.compaction.cancelled COUNT : 0
# rocksdb.number.keys.written COUNT : 0
# rocksdb.number.keys.read COUNT : 100000
# rocksdb.number.keys.updated COUNT : 0
# rocksdb.bytes.written COUNT : 0
# rocksdb.bytes.read COUNT : 0
# rocksdb.number.db.seek COUNT : 0
# rocksdb.number.db.next COUNT : 0
# rocksdb.number.db.prev COUNT : 0
# rocksdb.number.db.seek.found COUNT : 0
# rocksdb.number.db.next.found COUNT : 0
# rocksdb.number.db.prev.found COUNT : 0
# rocksdb.db.iter.bytes.read COUNT : 0
# rocksdb.no.file.closes COUNT : 0
# rocksdb.no.file.opens COUNT : 50
# rocksdb.no.file.errors COUNT : 0
# rocksdb.l0.slowdown.micros COUNT : 0
# rocksdb.memtable.compaction.micros COUNT : 0
# rocksdb.l0.num.files.stall.micros COUNT : 0
# rocksdb.stall.micros COUNT : 0
# rocksdb.db.mutex.wait.micros COUNT : 0
# rocksdb.rate.limit.delay.millis COUNT : 0
# rocksdb.num.iterators COUNT : 0
# rocksdb.number.multiget.get COUNT : 0
# rocksdb.number.multiget.keys.read COUNT : 0
# rocksdb.number.multiget.bytes.read COUNT : 0
# rocksdb.number.deletes.filtered COUNT : 0
# rocksdb.number.merge.failures COUNT : 0
# rocksdb.bloom.filter.prefix.checked COUNT : 0
# rocksdb.bloom.filter.prefix.useful COUNT : 0
# rocksdb.number.reseeks.iteration COUNT : 0
# rocksdb.getupdatessince.calls COUNT : 0
# rocksdb.block.cachecompressed.miss COUNT : 0
# rocksdb.block.cachecompressed.hit COUNT : 0
# rocksdb.block.cachecompressed.add COUNT : 0
# rocksdb.block.cachecompressed.add.failures COUNT : 0
# rocksdb.wal.synced COUNT : 0
# rocksdb.wal.bytes COUNT : 0
# rocksdb.write.self COUNT : 0
# rocksdb.write.other COUNT : 0
# rocksdb.write.timeout COUNT : 0
# rocksdb.write.wal COUNT : 0
# rocksdb.compact.read.bytes COUNT : 0
# rocksdb.compact.write.bytes COUNT : 61280472
# rocksdb.flush.write.bytes COUNT : 0
# rocksdb.number.direct.load.table.properties COUNT : 0
# rocksdb.number.superversion_acquires COUNT : 1
# rocksdb.number.superversion_releases COUNT : 0
# rocksdb.number.superversion_cleanups COUNT : 0
# rocksdb.number.block.compressed COUNT : 6973
# rocksdb.number.block.decompressed COUNT : 162952
# rocksdb.number.block.not_compressed COUNT : 0
# rocksdb.merge.operation.time.nanos COUNT : 0
# rocksdb.filter.operation.time.nanos COUNT : 0
# rocksdb.row.cache.hit COUNT : 0
# rocksdb.row.cache.miss COUNT : 0
# rocksdb.read.amp.estimate.useful.bytes COUNT : 0
# rocksdb.read.amp.total.read.bytes COUNT : 0
# rocksdb.number.rate_limiter.drains COUNT : 0
# rocksdb.number.iter.skip COUNT : 0
# rocksdb.txn.overhead.mutex.prepare COUNT : 0
# rocksdb.txn.overhead.mutex.old.commit.map COUNT : 0
# rocksdb.txn.overhead.duplicate.key COUNT : 0
# rocksdb.txn.overhead.mutex.snapshot COUNT : 0
# rocksdb.number.multiget.keys.found COUNT : 0
# rocksdb.num.iterator.created COUNT : 0
# rocksdb.num.iterator.deleted COUNT : 0
# rocksdb.num.gc.get_keys COUNT : 0
# rocksdb.num.gc.touch_files COUNT : 0
# rocksdb.num.gc.skip_by_seqno COUNT : 0
# rocksdb.num.gc.skip_by_file_meta COUNT : 0
# rocksdb.num.read.blob_valid COUNT : 100000
# rocksdb.num.read.blob_invalid COUNT : 0
# rocksdb.db.get.micros P50 : 218.232329 P95 : 592.026336 P99 : 820.013758 P99.9 : 952.416667 P100 : 1616.000000 COUNT : 100000 SUM : 26219901