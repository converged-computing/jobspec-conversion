#!/bin/bash
#SBATCH --job-name=A20-k1-ginf-l3
#SBATCH --output=job_%j.out
#SBATCH --error=job_%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=128
#SBATCH --mem=16G
#SBATCH --time=02:00:00
#SBATCH --partition=short
#SBATCH --constraint=ntasks-per-node=1
#SBATCH --dependency=5932351

export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'
export OMP_PLACES='threads'
export OMP_BIND_PROC='true'

export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
export OMP_PLACES=threads
export OMP_BIND_PROC=true
ml amd-modules
srun ball0x.exe > log.out 2> err.out 
