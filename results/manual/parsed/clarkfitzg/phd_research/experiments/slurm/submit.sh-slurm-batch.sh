#!/bin/bash
#SBATCH --job-name=find_word
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=2G

module load R
srun bash stream_find_word.sh
