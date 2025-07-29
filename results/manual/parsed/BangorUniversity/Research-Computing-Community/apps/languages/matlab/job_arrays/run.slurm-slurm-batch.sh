#!/bin/bash
#SBATCH --job-name=job_arrays
#SBATCH --account=scw1124
#SBATCH --output=logs/job_arrays.%A_%a.out
#SBATCH --error=logs/job_arrays.%A_%a.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:00:01
#SBATCH --array=1-4

module purge
module load matlab/R2019a
matlab -nodisplay -r "func(${SLURM_ARRAY_TASK_ID});exit"
