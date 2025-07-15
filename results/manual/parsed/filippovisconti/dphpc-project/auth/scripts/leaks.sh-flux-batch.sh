#!/bin/bash
#FLUX: --job-name=blake3valgrind
#FLUX: --priority=16

set -e
module load gcc/11.4.0 papi/7.0.1
make benchmark_mp
OMP_NUM_THREADS=32 valgrind --leak-check=full --show-leak-kinds=all --track-origins=yes --verbose --log-file=valgrind-out.txt ./benchmark
