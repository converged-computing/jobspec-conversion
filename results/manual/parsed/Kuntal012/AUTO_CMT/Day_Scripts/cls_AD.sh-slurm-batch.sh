#!/bin/bash
#SBATCH --job-name=PfCMT 
#SBATCH --output=./output_slurm/PfCMT.o
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=6G
#SBATCH --time=2-00:15:00
#SBATCH --partition=batch

date
echo 'PF_CMT;quit'|matlab -nodesktop
