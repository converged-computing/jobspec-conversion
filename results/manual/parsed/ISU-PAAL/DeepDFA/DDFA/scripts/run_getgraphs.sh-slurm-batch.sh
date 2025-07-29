#!/bin/bash
#SBATCH --job-name=getgraphs
#SBATCH --output=logs/getgraphs_%A_%a.out
#SBATCH --error=logs/getgraphs_%A_%a.out
#SBATCH --nodes=1
#SBATCH --ntasks=2
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=32GB
#SBATCH --time=1-00:00:00
#SBATCH --array=0-99%10

source activate.sh
if [ ! -z "$SLURM_ARRAY_TASK_ID"]
then
    jan="--job_array_number $SLURM_ARRAY_TASK_ID"
else
    jan=""
fi
python -u sastvd/scripts/getgraphs.py bigvul --sess $jan --num_jobs 100 --overwrite $@
