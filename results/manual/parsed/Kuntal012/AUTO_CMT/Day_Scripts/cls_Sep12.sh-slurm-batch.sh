#!/bin/bash
#SBATCH --job-name=PfSep12 
#SBATCH --output=./output_slurm/PfSep12.o
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=6G
#SBATCH --time=2-00:15:00

date
echo 'PF_Sep12;quit'|matlab -nodesktop
