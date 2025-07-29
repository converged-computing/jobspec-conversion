#!/bin/bash
#SBATCH --account=def-ibajic
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=50G
#SBATCH --time=06:00:00

module restore uneq
cd ..
python Korcan/pipeline.py 0 10 0 0
