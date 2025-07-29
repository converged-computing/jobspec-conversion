#!/bin/bash
#SBATCH --job-name=sample_ind
#SBATCH --account=pi-dachxiu
#SBATCH --output=../log/ind_output.txt
#SBATCH --error=../log/ind_error.txt
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=16g
#SBATCH --time=01:00:00
#SBATCH --partition=amd

module load python
python3 ./src/empirical/indstock_new.py
