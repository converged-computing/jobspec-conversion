#!/bin/bash
#SBATCH --job-name=com
#SBATCH --account=mh0033
#SBATCH --output=com.%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=0
#SBATCH --time=08:00:00
#SBATCH --partition=compute

mpirun -np 1 python -u composite_analysis.py $1 $2 $3
