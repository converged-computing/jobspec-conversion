#!/bin/bash
#SBATCH --job-name=PfSep9 
#SBATCH --output=./output_slurm/PfSep9.o
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=6G
#SBATCH --time=2-00:15:00

date
echo 'PF_Sep9;quit'|matlab -nodesktop
