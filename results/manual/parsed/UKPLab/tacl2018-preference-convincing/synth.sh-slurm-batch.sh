#!/bin/bash
#SBATCH --job-name=conv_rand
#SBATCH --output=./conv_pers_rand.out.%j
#SBATCH --error=./conv_pers_rand.err.%j
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=24
#SBATCH --mem=16384
#SBATCH --time=1-00:00:00
#SBATCH: --exclusive
#SBATCH --constraint=avx

module load intel python/3.6.8
OMP_NUM_THREADS=20 python3 -u python/analysis/simulations/synth_tests.py 0
OMP_NUM_THREADS=20 python3 -u python/analysis/simulations/synth_tests.py 1
