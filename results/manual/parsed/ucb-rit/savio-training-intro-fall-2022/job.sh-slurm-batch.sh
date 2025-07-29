#!/bin/bash
#SBATCH --job-name=test
#SBATCH --account=fc_paciorek
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:05:00
#SBATCH --partition=savio2

module load python/3.9.12
python calc.py >& calc.out
