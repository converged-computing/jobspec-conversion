#!/bin/bash
#SBATCH --job-name=fmriprep
#SBATCH --output=../derivatives/fmriprep/logs/fmriprep-%A_%a.log
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=20000
#SBATCH --time=15:00:00
#SBATCH --chdir=.
#SBATCH --array=31,39,53,68,81,88-122

echo "Purging modules"
module purge
echo "Slurm job ID: " $SLURM_JOB_ID
echo "Slurm array task ID: " $SLURM_ARRAY_TASK_ID
date
printf -v subj "%03d" $SLURM_ARRAY_TASK_ID
echo "Running fMRIPrep on sub-$subj"
./run_fmriprep.sh $subj
echo "Finished running fMRIPrep on sub-$subj"
date
