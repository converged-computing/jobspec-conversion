#!/bin/bash
#SBATCH --job-name=slope_forced
#SBATCH --account=mh0033
#SBATCH --output=slope_99.%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=0
#SBATCH --time=08:00:00
#SBATCH --partition=compute

mpirun -np 1 python -u gph_ens_std.py $1 $2 $3
