#!/bin/bash
#SBATCH --job-name=3dTproject
#SBATCH --output=../derivatives/logs/glm_both_%A_%a.log
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=4000
#SBATCH --time=01:00:00
#SBATCH --chdir=.
#SBATCH --array=31,39,53,68,81,88-122

echo "Purging modules"
module purge
module load afni
echo "Slurm job ID: " $SLURM_JOB_ID
echo "Slurm array task ID: " $SLURM_ARRAY_TASK_ID
date
printf -v subj "%03d" $SLURM_ARRAY_TASK_ID
echo "Running fMRIPrep on sub-$subj"
./run_glm.py $subj
echo "Finished running fMRIPrep on sub-$subj"
date
