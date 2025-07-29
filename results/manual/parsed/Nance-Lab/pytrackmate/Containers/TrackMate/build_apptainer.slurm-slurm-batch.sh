#!/bin/bash
#SBATCH --account=cheme
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=10G
#SBATCH --time=00:05:00
#SBATCH --chdir=.

export APPTAINERENV_NEWHOME='$(pwd)'

module load apptainer
export APPTAINERENV_NEWHOME=$(pwd)
apptainer build apptainerSif.sif docker://nlsschim/pytrackmate
