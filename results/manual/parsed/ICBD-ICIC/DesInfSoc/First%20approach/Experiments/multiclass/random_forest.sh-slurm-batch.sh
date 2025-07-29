#!/bin/bash
#SBATCH --job-name=itrust-random_forest
#SBATCH --output=outputs/random_forest-%A-%a.out
#SBATCH --error=errors/random_forest-%A-%a.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=8G
#SBATCH --time=01:00:00
#SBATCH --array=28,30,31,32,34,36

dataset="$1"
source ../.experiments_env/bin/activate
srun python random_forest.py ${SLURM_ARRAY_TASK_ID} "$dataset"
