#!/bin/bash
#SBATCH --job-name=v4Cost
#SBATCH --account=def-pelleti2
#SBATCH --mail-user=gabriel.pigeon@usherbrooke.ca
#SBATCH --mail-type=FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=35G
#SBATCH --time=6-00:23:55
#SBATCH --array=1-3

module load r/4.1.2
cd ~/projects/def-pelleti2/pigeonga/Trsw_justine/
Rscript --verbose R/4_runModel.R $SLURM_JOB_NAME $SLURM_ARRAY_TASK_ID
