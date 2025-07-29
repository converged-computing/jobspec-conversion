#!/bin/bash
#SBATCH --job-name=mriqc
#SBATCH --output=../derivatives/logs/mriqc-%A_%a.log
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=10000
#SBATCH --time=03:00:00
#SBATCH --array=1-345

echo "Purging modules"
module purge
echo "Slurm job ID: " $SLURM_JOB_ID
echo "Slurm array task ID: " $SLURM_ARRAY_TASK_ID
date
printf -v subj "%03d" $SLURM_ARRAY_TASK_ID
echo "Running MRIQC on sub-$subj"
./run_mriqc.sh $subj
echo "Finished running MRIQC on sub-$subj"
date
