#!/bin/bash
#SBATCH --job-name=test
#SBATCH --account=fc_paciorek
#SBATCH --nodes=1
#SBATCH --ntasks=48
#SBATCH --cpus-per-task=1
#SBATCH --time=00:30:00

module load python/3.6
python calc.py >& calc.out
