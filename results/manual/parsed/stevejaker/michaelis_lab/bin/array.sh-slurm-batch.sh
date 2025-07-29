#!/bin/bash
#SBATCH --mail-user=jparkman@byu.edu
#SBATCH --mail-type=FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=400M
#SBATCH --time=00:00:30
#SBATCH --constraint=avx2,ntasks-per-node=16
#SBATCH --array=1-16%1

LAST_PIECE=16
if [[ "${SLURM_ARRAY_TASK_ID}" -eq "1" ]]; then
        # If this is ARRAY_TASK_ID 1, sander1, we pass our Arguments here so we can run leap corectly
        runamber $SLURM_ARRAY_TASK_ID $@
elif [[ "${SLURM_ARRAY_TASK_ID}" -eq "${LAST_PIECE}" ]]; then
        runamber $SLURM_ARRAY_TASK_ID -L
else
        # If it is not ARRAY_TASK_ID 1, just run the next job in the line
        runamber $SLURM_ARRAY_TASK_ID
fi
