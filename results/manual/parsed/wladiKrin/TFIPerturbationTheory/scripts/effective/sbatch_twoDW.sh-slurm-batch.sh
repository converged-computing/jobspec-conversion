#!/bin/bash
#SBATCH --job-name=2DW
#SBATCH --output=log_eff2DW%a
#SBATCH --error=log_eff2DW%a
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=48
#SBATCH --constraint=ntasks-per-node=1
#SBATCH --array=1-10

srun julia -t 48 Heff_twoDWStates.jl ${SLURM_ARRAY_TASK_ID}
