#!/bin/bash
#SBATCH --job-name=short_time_phase_diagram
#SBATCH --output=short_time_phase_diagram-%a_%A.out
#SBATCH --error=short_time_phase_diagram-%a_%A.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=20gb
#SBATCH --constraint=ntasks-per-node=1

srun julia run/phase_diagram.jl $SLURM_ARRAY_TASK_ID $1
