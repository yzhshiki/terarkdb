# REQUIRE: ProjectRootPath/build
db_path="/mnt/nvme0n1"
# rm /mnt/nvme0n1/*
# rm  $db_path + "/*"
# sudo dd if=/dev/zero of=/dev/nvme0n1 bs=4M status=progress

./db_bench --benchmarks="fillrandom,stats" --statistics --db=$db_path \
--disable_auto_compactions=false --enable_lazy_compaction=false \
--blob_size=1024  --value_size=16000 --num=100000 --histogram=1 \
--blob_gc_ratio=0.01 >> lab1_fillrandom.txt

# ./db_bench --benchmarks="readrandomwriterandom,stats" --statistics --db=$db_path --use_existing_db=true \
# --disable_auto_compactions=false --enable_lazy_compaction=false \
# --blob_size=1024  --value_size=16000 --num=100000 --histogram=1 \
# --readwritepercent=75  --blob_gc_ratio=0.99 --cache_size=16000000 \
# >> lab2_readrandomwriterandom.txt

# ./db_bench --benchmarks="readwhilewriting,stats" --statistics --db=$db_path --use_existing_db=true \
# --disable_auto_compactions=false --enable_lazy_compaction=false \
# --blob_size=1024  --value_size=16000 --num=1000000 --histogram=1 \
# --blob_gc_ratio=0.01 \
# >> lab2_readwhilewriting.txt

# ./db_bench --benchmarks="overwrite,stats" --statistics --db=$db_path \
# --disable_auto_compactions=false --enable_lazy_compaction=false \
# --blob_size=1024  --value_size=16000 --num=10000000 --blob_gc_ratio=0.1>> lab1_overwrite.txt

# ./db_bench --benchmarks="fillseq,stats" --statistics --db=$db_path \
# --disable_auto_compactions=true --enable_lazy_compaction=false \
# --blob_size=1024  --value_size=16000 --num=100000 --histogram=1 \
# >> lab1_write.txt

# ./db_bench --benchmarks="readrandom" --statistics  \
#  --db=$db_path --use_existing_db=true \
#  --use_direct_reads=true --mmap_read=false \
#  --cache_index_and_filter_blocks=true \
#  --disable_auto_compactions=true \
#  --blob_size=1024 --value_size=5000 --num=10000 --cache_size=16000000 \
#  --duration=0 \
#  --threads=1 >> lab1_read.txt


# perf record -e cycles:u -g --call-graph dwarf -F 1000 \
# ./db_bench --benchmarks="readrandom" --statistics  \
#  --db=$db_path --use_existing_db=true \
#  --use_direct_reads=true --mmap_read=false \
#  --cache_index_and_filter_blocks=true \
#  --disable_auto_compactions=false \
#  --blob_size=1024 --value_size=16000 --num=100000 --cache_size=16000000 \
#  --duration=0 \
#  --threads=1 >> lab1_read.txt

 # for gdb
#  gdb --args ./db_bench --benchmarks="readrandom" --statistics  \
#  --db=$db_path --use_existing_db=true \
#  --use_direct_reads=true --mmap_read=false \
#  --cache_index_and_filter_blocks=true \
#  --disable_auto_compactions=true \
#  --blob_size=1024 --value_size=16000 --num=10000 --cache_size=1600000 \
#  --duration=0 \
#  --threads=1

# perf report -g --no-children >> a_value_handle_cache_size_perf_nochild.txt
# perf report -g --percent-limit 10 >> a_value_handle_cache_size_perf_limit.txt
# perf report -g -n 10 >> a_value_handle_cache_size_perf_n.txt
# data_size = 16k * 100K = 1.6G
# cache_size = 0.16, 1.6, 16, 160, 1600M!



 