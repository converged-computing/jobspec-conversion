#!/bin/bash
#SBATCH --job-name=cache_analysis
#SBATCH --output=cache_%j.out
#SBATCH --error=cache_%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:0
#SBATCH --partition=edu5
#SBATCH --constraint=ntasks-per-node=1

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
