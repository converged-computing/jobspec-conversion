#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=1-06:00:00

python2 generate_goodenough_resolution.py $SLURM_ARRAY_TASK_ID
