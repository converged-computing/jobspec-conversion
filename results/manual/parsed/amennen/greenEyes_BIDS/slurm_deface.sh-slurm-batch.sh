#!/bin/bash
#SBATCH --job-name=deface
#SBATCH --output=../derivatives/deface/logs/deface-%A_%a.log
#SBATCH --mail-user=amennen@princeton.edu
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=20000
#SBATCH --time=01:00:00
#SBATCH --partition=all
#SBATCH --array=2-14,16-19,25-26,28-33,35-46

echo "Purging modules"
module purge
echo "Slurm job ID: " $SLURM_JOB_ID
echo "Slurm array task ID: " $SLURM_ARRAY_TASK_ID
date
printf -v subj "%03d" $SLURM_ARRAY_TASK_ID
echo "Running pydeface on sub-$subj"
./deface.sh $subj
echo "Finished running pydeface on sub-$subj"
date
