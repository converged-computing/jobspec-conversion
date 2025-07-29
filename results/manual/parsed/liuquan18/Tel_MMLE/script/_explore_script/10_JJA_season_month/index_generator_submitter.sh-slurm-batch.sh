#!/bin/bash
#SBATCH --job-name=ind_gen
#SBATCH --account=mh0033
#SBATCH --output=ind_gen.%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=500G
#SBATCH --time=04:00:00
#SBATCH --partition=compute

mpirun -np 1 python -u index_generator.py $1 $2 $3
