#!/bin/bash
#SBATCH --job-name=picklesauce
#SBATCH --output=./slurm_logs/hgcal_electron_pickles.log
#SBATCH --mail-user=evans908@umn.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=50g
#SBATCH --time=04:00:00
#SBATCH --partition=amd2tb

export PYTHONUNBUFFERED='1'

date=$(date +%d_%m_%Y__%H_%M)
export PYTHONUNBUFFERED=1
module load cmake
module load gcc
module load python3
module load cuda/10.1
module load graphviz
conda activate /home/rusack/shared/.conda/env/torch1.7
