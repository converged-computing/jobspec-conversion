#!/bin/bash
#SBATCH --job-name=term
#SBATCH --output=logs/%A_%a.out
#SBATCH --error=logs/%A_%a.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=64G
#SBATCH --time=03:59:00
#SBATCH --constraint=ntasks-per-node=1

module load julia/1.9.1
srun --export=ALL julia -t $NUM_THREADS run.jl $SLURM_ARRAY_TASK_ID "della"
