#!/bin/bash
#SBATCH --job-name=fmriprep
#SBATCH --output=../../data/bids/derivatives/fmriprep/logs/fmriprep-%A_%a.log
#SBATCH --mail-user=YOUREMAIL@princeton.edu
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=20000
#SBATCH --time=18:00:00
#SBATCH --array=001,

echo "Purging modules"
module purge
echo "Slurm job ID: " $SLURM_JOB_ID
date
printf -v subj "%03d" $SLURM_ARRAY_TASK_ID
echo "Running fMRIPrep on sub-$subj"
./run_fmriprep.sh $subj
echo "Finished running fMRIPrep on sub-$subj"
date
echo "Defacing preprocessed T1w for sub-$subj"
./deface_template.sh $subj
echo "Finished defacing T1w"
