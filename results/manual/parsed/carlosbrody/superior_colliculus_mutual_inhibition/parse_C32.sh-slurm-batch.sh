#!/bin/bash
#SBATCH --job-name=parseC32
#SBATCH --output=log-parseC32-%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=4-00:00:00
#SBATCH --partition=Brody

module load julia/0.6.3
echo "Slurm Job ID: $SLURM_JOB_ID"
echo "Slurm Array Task ID: $SLURM_ARRAY_TASK_ID"
julia C32_parse_finished.jl 
