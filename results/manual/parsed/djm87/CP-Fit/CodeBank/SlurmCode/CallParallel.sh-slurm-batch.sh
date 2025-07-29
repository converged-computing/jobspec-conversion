#!/bin/bash
#SBATCH --job-name=WE43_Maud_Refinements
#SBATCH --output=WE43_Maud_Refinements_%A-%a.out
#SBATCH --error=array_%A-%a.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=01:00:00
#SBATCH --partition=thrust2
#SBATCH --array=0-0

declare -a runStart=(1)
declare -a runEnd=(7)
seq ${runStart[${SLURM_ARRAY_TASK_ID}]} ${runEnd[${SLURM_ARRAY_TASK_ID}]} | xargs -n 1 -P 7 bash Maud_batch.sh
