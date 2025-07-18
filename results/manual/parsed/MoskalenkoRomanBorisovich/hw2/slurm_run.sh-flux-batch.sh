#!/bin/bash
#FLUX: --job-name=cowy-pancake-2545
#FLUX: -t=3600
#FLUX: --urgency=16

mkdir -p bemchmark_results
module load module load nvidia_sdk/nvhpc/23.5
N_RUNS=10
SEED=12345
echo starting
echo n_runs: $N_RUNS seed: $SEED
echo
for matrix_size in 2000 3000 4000 5000; do
    echo matrix_size: $matrix_size
    echo run cuda
    ./build/main_cu $matrix_size $N_RUNS $SEED >bemchmark_results/cuda_${matrix_size}.csv
    echo cuda finished
    echo run omp
    ./build/main_omp $matrix_size $N_RUNS $SEED >bemchmark_results/omp_${matrix_size}.csv
    echo omp finished
done
