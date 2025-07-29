#!/bin/bash
#SBATCH --job-name=PfSep10 
#SBATCH --output=./output_slurm/PfSep10.o
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=6G
#SBATCH --time=2-00:15:00
#SBATCH --partition=batch

date
echo 'PF_Sep10;quit'|matlab -nodesktop
