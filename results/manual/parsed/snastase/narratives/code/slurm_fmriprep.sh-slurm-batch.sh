#!/bin/bash
#SBATCH --job-name=fmriprep
#SBATCH --output=../derivatives/logs/fmriprep-res-native-v20.0.5-%A_%a.log
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=12000
#SBATCH --time=16:00:00
#SBATCH --partition=all
#SBATCH --array=1-345

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
