#!/bin/bash
#FLUX: --job-name=psycho-poo-3268
#FLUX: --urgency=16

export OMP_NUM_THREADS='1'

export OMP_NUM_THREADS=1
module load cmake/gcc/3.18.0
module load openmpi/gcc/64/1.10.7
module load nvidia_hpcsdk
module load gcc/9.2.0
rm -rf build
rm -rf ./out/perf/*
mkdir build
cd build
cmake ..
make
touch ../out/perf/mm_perf_out_small
for i in {1..28}
do
OMP_NUM_THREADS=$i ./matrixmatrix ../etc/2by3matrix.mtx ../etc/3by2matrix.mtx ../etc/r2testoutmmsmall.mtx >> ../out/perf/mm_perf_out_small
OMP_NUM_THREADS=$i ./matrixmatrix ../etc/50by30matrix.mtx ../etc/30by20matrix.mtx ../etc/r2testoutmmmedium.mtx >> ../out/perf/mm_perf_out_med
OMP_NUM_THREADS=$i ./matrixmatrix ../etc/1000by1000matrix.mtx ../etc/1000by1000matrix2.mtx ..etc/r2testoutmmlarge.mtx >> ../out/perf/mm_perf_out_large
done
