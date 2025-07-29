#!/bin/bash
#SBATCH --job-name=grabDeut
#SBATCH --output=logs/deut_grabow.%a.log
#SBATCH --error=logs/deut_grabow.%a.slurm.log
#SBATCH --mail-user=blais.ch@northeastern.edu
#SBATCH --mail-type=FAIL,END
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=20GB
#SBATCH --time=02:00:00
#SBATCH --partition=short
#SBATCH --array=0-175
#SBATCH --exclude=c5003

source ~/_02_RMG_envs/RMG_julia_env/.config_file
source activate rmg_julia_env
python -u Grabow_sbr_script.py  #$CTI_FILE $RMG_MODEL
