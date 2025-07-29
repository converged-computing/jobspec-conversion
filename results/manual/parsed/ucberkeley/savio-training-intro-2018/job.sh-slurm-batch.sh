#!/bin/bash
#SBATCH --job-name=test
#SBATCH --account=co_stat
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:00:30
#SBATCH --partition=savio2

module load python/3.6
python calc.py >& calc.out
