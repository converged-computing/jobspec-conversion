#!/bin/bash
#SBATCH --job-name=struct_marl
#SBATCH --output=logs/%j.log
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --mem=4G
#SBATCH --time=12:00:00
#SBATCH --array=1-2

./run.sh $1 $2 $SLURM_ARRAY_TASK_ID
