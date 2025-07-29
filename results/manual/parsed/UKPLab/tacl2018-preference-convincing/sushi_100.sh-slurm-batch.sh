#!/bin/bash
#SBATCH --job-name=sushi_100
#SBATCH --output=./sushi_100.out.%j
#SBATCH --error=./sushi_100.err.%j
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=24
#SBATCH --mem=16384
#SBATCH --time=1-00:00:00
#SBATCH --exclusive
#SBATCH --constraint=avx

module load intel python/3.6.8
OMP_NUM_THREADS=8 python3 -u python/analysis/sushi_10_tests.py 0
OMP_NUM_THREADS=8 python3 -u python/analysis/sushi_10_tests.py 2
OMP_NUM_THREADS=8 python3 -u python/analysis/sushi_10_tests.py 4
