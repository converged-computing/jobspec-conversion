#!/bin/bash
#SBATCH --account=project_xxxx
#SBATCH --nodes=1
#SBATCH --ntasks=40
#SBATCH --cpus-per-task=1
#SBATCH --time=15:10:10
#SBATCH --partition=small

module load maestro 
bash script_file.sh
