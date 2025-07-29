#!/bin/bash
#SBATCH --job-name=drag-force
#SBATCH --output=out.%j
#SBATCH --nodes=1
#SBATCH --ntasks=256
#SBATCH --cpus-per-task=1
#SBATCH --time=12:00:00
#SBATCH --partition=normal

ulimit -c 0
set -x
ibrun python drag-force-mla.py
