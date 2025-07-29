#!/bin/bash
#SBATCH --job-name=tabnet
#SBATCH --account=m1248
#SBATCH --output=IOD-train-tabnet.%j.out
#SBATCH --error=IOD-train-tabnet.%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=10:10:00
#SBATCH --partition=regular
#SBATCH --constraint=haswell

module load python3/3.9-anaconda-2021.11
module list
set -x
srun -l -u python ./IOD-train-tabnet.py
