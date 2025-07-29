#!/bin/bash
#SBATCH --job-name=sra_search
#SBATCH --account=ctbrowngrp
#SBATCH --output=logs/%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=32
#SBATCH --mem=20GB
#SBATCH --time=4-04:00:00

cd $SLURM_SUBMIT_DIR
source ~/.bashrc
conda activate sra_search
set -o nounset
set -o errexit
set -x
snakemake -j 32 --use-conda -p
echo ${SLURM_JOB_NODELIST}       # Output Contents of the SLURM NODELIST
env | grep SLURM            # Print out values of the current jobs SLURM environment variables
scontrol show job ${SLURM_JOB_ID}     # Print out final statistics about resource uses before job exits
