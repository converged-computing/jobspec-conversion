#!/bin/bash
#SBATCH --job-name=rand_one
#SBATCH --account=mh0033
#SBATCH --output=rand_one.%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=0
#SBATCH --time=04:00:00

mpirun -np 1 python -u random_index_generator.py $1 $2 $3
