#!/bin/bash
#SBATCH --job-name=testjob
#SBATCH --account=cmsml3
#SBATCH --output=output-%A_%a.out
#SBATCH --error=error-%A_%a.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=1GB
#SBATCH --time=00:10:00
#SBATCH --constraint=ntasks-per-node=1
#SBATCH --array=0-100

cd $SLURM_SUBMIT_DIR
myCalculations $SLURM_ARRAY_TASK_ID
