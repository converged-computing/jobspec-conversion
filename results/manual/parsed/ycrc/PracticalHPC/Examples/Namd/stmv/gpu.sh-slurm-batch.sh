#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --gres=gpu:4
#SBATCH --time=00:24:00

module load NAMD/2.13-multicore-CUDA
namd2 +idlepoll +ppn $SLURM_CPUS_ON_NODE stmv.namd 
