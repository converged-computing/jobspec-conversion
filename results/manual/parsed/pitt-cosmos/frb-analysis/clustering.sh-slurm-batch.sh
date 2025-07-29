#!/bin/bash
#SBATCH --job-name=REPROCESS_CUTS
#SBATCH --output=logs/cut_800.out
#SBATCH --mail-user=yig20@pitt.edu
#SBATCH --mail-type=end
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=4000MB
#SBATCH --time=3-18:00:00
#SBATCH --constraint=ntasks-per-node=1

python clustering.py 800 1000
