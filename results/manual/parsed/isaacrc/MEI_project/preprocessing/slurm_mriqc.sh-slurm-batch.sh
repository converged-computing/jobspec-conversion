#!/bin/bash
#SBATCH --job-name=mriqc
#SBATCH --output=../../data/bids/derivatives/mriqc/logs/mriqc-%A_%a.log
#SBATCH --mail-user=isaacrc@princeton.edu
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=14000
#SBATCH --time=03:00:00
#SBATCH --partition=all
#SBATCH --array=015,016,017

echo "Purging modules"
module purge
echo "Slurm job ID: " $SLURM_JOB_ID
date
printf -v subj "%03d" $SLURM_ARRAY_TASK_ID
echo "Running MRIQC on sub-$subj"
./run_mriqc.sh $subj
echo "Finished running MRIQC on sub-$subj"
date
echo "Running MRIQC on group"
./run_mriqc_group.sh
echo "Finished running MRIQC on group"
date
