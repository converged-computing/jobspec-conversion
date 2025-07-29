#!/bin/bash
#SBATCH --job-name=PF_April12 
#SBATCH --output=./output_slurm/PF_April12.o
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=4G
#SBATCH --time=1-00:15:00
#SBATCH --partition=batch

date
echo 'PF_April12;quit'|matlab -nodesktop
