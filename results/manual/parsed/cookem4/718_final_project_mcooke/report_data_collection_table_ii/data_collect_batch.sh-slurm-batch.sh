#!/bin/bash
#SBATCH --job-name=mcooke_table_ii
#SBATCH --output=table_ii_%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=12:00:00
#SBATCH --constraint=ntasks-per-node=40

module load NiaEnv/2019b
module load cmake
module load gcc
module load python/3
module load valgrind
python3 sweep_ntt_impl.py
