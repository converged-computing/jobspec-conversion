#!/bin/bash
#SBATCH --job-name=matinv
#SBATCH --mail-user=<YourNetID>@princeton.edu
#SBATCH --mail-type=fail
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=4G
#SBATCH --time=00:01:00

module purge
module load anaconda3/2023.9
kernprof -l matrix_inverse.py
