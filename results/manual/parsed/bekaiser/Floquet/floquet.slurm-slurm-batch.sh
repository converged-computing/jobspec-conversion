#!/bin/bash
#SBATCH --job-name=floq
#SBATCH --output=job_%j.out
#SBATCH --error=job_%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=2-00:00:00

source ~/dedalus_paths
module list
python3 floquet.py
