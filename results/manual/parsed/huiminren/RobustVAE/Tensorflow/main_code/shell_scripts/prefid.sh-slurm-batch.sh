#!/bin/bash
#SBATCH --output=prefid_rvae.out
#SBATCH --nodes=1
#SBATCH --ntasks=8
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=16G

sacct --format="CPUTime,MaxRSS"
python ../fid_computation/prefid.py
