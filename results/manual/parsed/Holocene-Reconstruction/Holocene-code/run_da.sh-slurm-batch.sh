#!/bin/bash
#SBATCH --job-name=da_Holocene
#SBATCH --output=output_logfile.txt
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=50000
#SBATCH --time=06:00:00

srun python -u da_main_code.py config.yml
