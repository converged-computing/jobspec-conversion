#!/bin/bash
#SBATCH --job-name=rvae_sp
#SBATCH --output=rvae_sp.out
#SBATCH --nodes=1
#SBATCH --ntasks=16
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=64G

sacct --format="CPUTime,MaxRSS"
python ../RobustVariationalAutoencoder.py
