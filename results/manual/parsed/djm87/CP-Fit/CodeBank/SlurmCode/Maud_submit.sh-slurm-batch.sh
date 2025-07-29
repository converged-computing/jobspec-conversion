#!/bin/bash
#SBATCH --job-name=WE43_Maud_refinements
#SBATCH --output=array_%A-%a.out
#SBATCH --error=array_%A-%a.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=8gb
#SBATCH --time=00:30:00
#SBATCH --array=0-3

find . -name \*CPU* -type f -delete
declare -a runStart=(1 33 65 97)
declare -a runEnd=(32 64 96 106)
seq ${runStart[${SLURM_ARRAY_TASK_ID}]} ${runEnd[${SLURM_ARRAY_TASK_ID}]} | xargs -n 1 -P 32 bash Maud_batch.sh
