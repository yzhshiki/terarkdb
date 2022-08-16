# REQUIRE: ProjectRootPath/build
rm -r tmp
./db_bench --benchmarks="fillseq,stats" --statistics --blob_size=1024 \
 --value_size=16000 --db=./tmp --num=100000 --disable_auto_compactions=true
 
./db_bench --benchmarks="readrandom" --statistics --blob_size=1024 \
 --db=./tmp --use_existing_db=true \
 --use_direct_reads=true --mmap_read=false \
 --cache_index_and_filter_blocks=true \
 --disable_auto_compactions=true \
 --value_size=16000  --num=100000 --cache_size=16000000 --duration=0 \
 --threads=1 >> a_concurrent_read_reslut.txt

 ./db_bench --benchmarks="readrandom" --statistics --blob_size=1024 \
 --db=./tmp --use_existing_db=true \
 --use_direct_reads=true --mmap_read=false \
 --cache_index_and_filter_blocks=true \
 --disable_auto_compactions=true \
 --value_size=16000  --num=100000 --cache_size=16000000 --duration=0 \
 --threads=2 >> a_concurrent_read_reslut.txt

 ./db_bench --benchmarks="readrandom" --statistics --blob_size=1024 \
 --db=./tmp --use_existing_db=true \
 --use_direct_reads=true --mmap_read=false \
 --cache_index_and_filter_blocks=true \
 --disable_auto_compactions=true \
 --value_size=16000  --num=100000 --cache_size=16000000 --duration=0 \
 --threads=4 >> a_concurrent_read_reslut.txt

 ./db_bench --benchmarks="readrandom" --statistics --blob_size=1024 \
 --db=./tmp --use_existing_db=true \
 --use_direct_reads=true --mmap_read=false \
 --cache_index_and_filter_blocks=true \
 --disable_auto_compactions=true \
 --value_size=16000  --num=100000 --cache_size=16000000 --duration=0 \
 --threads=8 >> a_concurrent_read_reslut.txt

 ./db_bench --benchmarks="readrandom" --statistics --blob_size=1024 \
 --db=./tmp --use_existing_db=true \
 --use_direct_reads=true --mmap_read=false \
 --cache_index_and_filter_blocks=true \
 --disable_auto_compactions=true \
 --value_size=16000  --num=100000 --cache_size=16000000 --duration=0 \
 --threads=16 >> a_value_handle_concurrent_read_reslut.txt


# data_size = 16k * 100K = 1.6G
# cache_size = 16M
# 1 2 4 8 16 threads!