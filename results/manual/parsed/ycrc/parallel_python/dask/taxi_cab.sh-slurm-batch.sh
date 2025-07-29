#!/bin/bash
#SBATCH --job-name=dask
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

module load dask
python taxi_cab.py  
