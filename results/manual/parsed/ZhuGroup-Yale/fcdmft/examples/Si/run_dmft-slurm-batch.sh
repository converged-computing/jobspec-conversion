#!/bin/bash
#SBATCH --output=run_dmft.out
#SBATCH --nodes=4
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=7
#SBATCH --mem=126000
#SBATCH --time=5-00:00:00
#SBATCH --constraint=ntasks-per-node=4

srun hostname
MKL_NUM_THREADS=7 OMP_NUM_THREADS=7 mpirun -np 16 python -u run_dmft.py
