#!/bin/bash
#SBATCH --job-name=prob-multiproc
#SBATCH --output=logs/%x-%j.out
#SBATCH --nodes=3
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=05:00:00
#SBATCH --constraint=haswell

module load pytorch/v1.6.0
srun -n 96 -c 2 python $HOME/mldas/mldas/assess.py probmap -c $HOME/mldas/configs/assess.yaml -o $SCRATCH/probmaps --mpi
