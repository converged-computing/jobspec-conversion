#!/bin/bash
#SBATCH --job-name=cloud
#SBATCH --nodes=1
#SBATCH --ntasks=8
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=15000mb
#SBATCH --time=01:00:00

module load Python/3.4.3-goolf-2015a
mpirun -np 8 python mpigeneric.py
