#!/bin/bash
#FLUX: --job-name=cache_analysis
#FLUX: --queue=edu5
#FLUX: --priority=16

export USER_COMPILE_FLAGS='-O3'

rm -rf bin/
rm -rf output/
mkdir output/
rm -rf valgrind/
mkdir valgrind/
export USER_COMPILE_FLAGS=-O3
make
srun valgrind --tool=cachegrind --cache-sim=yes --cachegrind-out-file=valgrind/simple_transpose.out ./bin/simple_transpose 12
srun valgrind --tool=cachegrind --cache-sim=yes --cachegrind-out-file=valgrind/block_transpose.out ./bin/block_transpose 12
