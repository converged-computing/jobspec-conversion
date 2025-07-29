#!/bin/bash
#SBATCH --job-name=PfSep23 
#SBATCH --output=./output_slurm/PfSep23.o
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=6G
#SBATCH --time=2-00:15:00
#SBATCH --partition=batch

date
echo 'PF_Sep23;quit'|matlab -nodesktop
