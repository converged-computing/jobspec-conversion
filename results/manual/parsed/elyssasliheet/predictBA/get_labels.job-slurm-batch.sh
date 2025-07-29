#!/bin/bash
#SBATCH --job-name=get_labels
#SBATCH --output=get_labels.txt
#SBATCH --mail-user=esliheet@smu.edu
#SBATCH --mail-type=all
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=256GB
#SBATCH --exclusive

module load intel/2023.1
module load mpi
python get_labels.py
