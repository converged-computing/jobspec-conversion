#!/bin/bash
#FLUX: --job-name=evasive-rabbit-5354
#FLUX: --priority=16

module load cesga/2020 cuda/12.2.0
cd build
cmake -DCMAKE_BUILD_TYPE=Release ..
sleep 1
make clean
sleep 1
make VERBOSE=1
sleep 1
EXECUTABLE=../bin/bench_base
for i in 1000000000
do
    for j in cuda
    do
        OMP_NUM_THREADS=32 $EXECUTABLE $i 5 $j betapdf
        OMP_NUM_THREADS=32 $EXECUTABLE $i 5 $j betacdf
    done
done
