#!/bin/bash
#SBATCH --account=account
#SBATCH --output=slurm-%j.out
#SBATCH --error=slurm-%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=5
#SBATCH --mem=100Gb
#SBATCH --time=00:05:00
#SBATCH --partition=partition
#SBATCH --array=1-5

export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'

date +"%d %B %Y %H:%M:%S"
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
source ~/.bash_profile
Rscript $protocol_dir/STAR_protocols_GV_calling/scripts/determineVariantStatus.R $SLURM_ARRAY_TASK_ID
date +"%d %B %Y %H:%M:%S"
