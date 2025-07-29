#!/bin/bash
#SBATCH --job-name=SW-PARALLEL
#SBATCH --account=lc_pv
#SBATCH --output=STREAM_OUTPUT
#SBATCH --nodes=1
#SBATCH --ntasks=32
#SBATCH --cpus-per-task=1
#SBATCH --time=04:00:00
#SBATCH --partition=priya
#SBATCH --constraint=IB

srun -n 32 --mpi=pmi2 /staging/pv/kris658/SOFTWARE/anaconda_2018_12/bin/python3.7 run.py
exit 0
