#!/bin/bash
#SBATCH --job-name=PF_May28 
#SBATCH --output=./output_slurm/PF_May28.o
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=4G
#SBATCH --time=1-00:15:00

date
echo 'PF_May28;quit'|matlab -nodesktop
