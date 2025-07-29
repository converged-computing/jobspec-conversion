#!/bin/bash
#SBATCH --job-name=PfSep18 
#SBATCH --output=./output_slurm/PfSep18.o
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=6G
#SBATCH --time=2-00:15:00

date
echo 'PF_Sep18;quit'|matlab -nodesktop
