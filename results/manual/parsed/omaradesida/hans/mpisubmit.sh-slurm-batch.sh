#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=2012
#SBATCH --time=00:10:00
#SBATCH --constraint=ntasks-per-node=4

srun -n 4 python mpihans.py<input.txt #> MPI_hans.out
