#!/bin/bash
#SBATCH --job-name=AR_sim
#SBATCH --output=./SLURMOUT/slurm_log_%A-%a.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=10g
#SBATCH --time=2-00:00:00
#SBATCH --array=1-200

module add matlab
matlab -nodesktop -nosplash -singleCompThread -r CMH_ar1 -logfile ./logfiles/testingArray_$SLURM_ARRAY_TASK_ID.out
