#!/bin/bash
#SBATCH --job-name=virtual_screen
#SBATCH --account=def-jeromew
#SBATCH --output=out/%x_${SLURM_ARRAY_JOB_ID}.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=3-00:00:00
#SBATCH --array=1-10

echo "Starting task $SLURM_ARRAY_TASK_ID"
python3 dock_df.py -t drd3 -df data/split/split_batch_${SLURM_ARRAY_TASK_ID}.csv -o data/scored/scored_${SLURM_ARRAY_TASK_ID}.csv -s cedar
