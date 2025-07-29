#!/bin/bash
#SBATCH --output=python_array_%a.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=500M
#SBATCH --time=00:30:00
#SBATCH --array=1-100

module load scicomp-python-env # use the normal scicomp environment for python
srun python serial.py
