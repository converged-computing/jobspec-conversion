#!/bin/bash
#SBATCH --job-name=3dTproject
#SBATCH --output=../derivatives/logs/3dTproject-%A_%a.log
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=12000
#SBATCH --time=04:00:00
#SBATCH --partition=all
#SBATCH --array=1-345

echo "Purging modules"
module purge
echo "Loading AFNI module afni/2019.10.09"
module load afni/2019.10.09
afni --version
echo "Slurm job ID: " $SLURM_JOB_ID
echo "Slurm array task ID: " $SLURM_ARRAY_TASK_ID
date
printf -v subj "%03d" $SLURM_ARRAY_TASK_ID
echo "Running spatial smoothing on sub-$subj"
./run_regression.py $subj fsaverage6 afni-smooth
echo "Finished spatially smoothing sub-$subj"
date
