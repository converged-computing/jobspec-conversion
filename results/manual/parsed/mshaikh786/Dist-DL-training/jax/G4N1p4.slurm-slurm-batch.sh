#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --cpus-per-task=4
#SBATCH --gres=4
#SBATCH --time=00:05:00
#SBATCH --constraint=a100

export IMAGE='$JAX_IMAGE'

scontrol show job ${SLURM_JOBID} 
module load dl
module load jax/23.10-sif
export IMAGE=$JAX_IMAGE
srun -u -n ${SLURM_NTASKS} -N ${SLURM_NNODES} singularity run --nv $IMAGE python query_v1.py
