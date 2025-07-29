#!/bin/bash
#SBATCH --job-name=dask
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --partition=admintest

module load dask
python taxi_cab.py  
