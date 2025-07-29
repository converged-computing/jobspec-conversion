#!/bin/bash
#SBATCH --job-name=PF_May10 
#SBATCH --output=./output_slurm/PF_May10.o
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=4G
#SBATCH --time=1-00:15:00

date
echo 'PF_May10;quit'|matlab -nodesktop
