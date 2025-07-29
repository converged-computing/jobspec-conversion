#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:30:00

rm results/$SLURM_ARRAY_TASK_ID/long.csv
if [ -f results/$SLURM_ARRAY_TASK_ID/out.long ]; then
    Rscript convert.R $SLURM_ARRAY_TASK_ID
fi
