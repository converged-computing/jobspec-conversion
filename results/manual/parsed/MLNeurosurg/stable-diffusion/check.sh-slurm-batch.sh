#!/bin/bash
#SBATCH --job-name=data
#SBATCH --account=precisionhealth_project1
#SBATCH --mail-user=achowdur@umich.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=5g
#SBATCH --time=5-00:00:00
#SBATCH --constraint=ntasks-per-node=24

python check_data.py
