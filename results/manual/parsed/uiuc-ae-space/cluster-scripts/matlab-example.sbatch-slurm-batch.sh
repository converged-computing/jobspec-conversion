#!/bin/bash
#SBATCH --job-name=matlab-example
#SBATCH --output=logs/%x_%j.out
#SBATCH --error=logs/%x_%j.err
#SBATCH --mail-user=netID@illinois.edu
#SBATCH --mail-type=BEGIN,FAIL,END
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=04:00:00
#SBATCH --constraint=ntasks-per-node=40

cd /scratch/users/netID/matlab-file-directory/
unset DISPLAY
module load matlab/9.7
matlab -nodisplay -r main.m >& logs/${SLURM_JOB_NAME}_${SLURM_JOB_ID}.oe
