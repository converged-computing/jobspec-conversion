#!/bin/bash
#SBATCH --job-name=train-cori
#SBATCH --output=logs/%x-%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:30:00
#SBATCH --partition=debug
#SBATCH --constraint=haswell

export OMP_NUM_THREADS='32'
export KMP_AFFINITY='granularity=fine,compact,1,0'
export KMP_BLOCKTIME='1'

module load pytorch/v1.5.0
export OMP_NUM_THREADS=32
export KMP_AFFINITY="granularity=fine,compact,1,0"
export KMP_BLOCKTIME=1
srun -l -u python train.py -d mpi $@
