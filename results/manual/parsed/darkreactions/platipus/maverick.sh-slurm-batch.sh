#!/bin/bash
#SBATCH --job-name=platipus
#SBATCH --output=platipus.o%j
#SBATCH --error=platipus.e%j
#SBATCH --mail-user=vshekar@haverford.edu
#SBATCH --mail-type=all
#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --cpus-per-task=1
#SBATCH --time=08:00:00

ibrun --multi-prog
