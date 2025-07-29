#!/bin/bash
#SBATCH --job-name=synthetic
#SBATCH --output=logs/output%x%j.out
#SBATCH --error=logs/error%x%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=32G
#SBATCH --time=00:10:00

      # nom du job
module load conda/py3-latest
source activate py310
python syntheticMonitoring.py
