#!/bin/bash
#SBATCH --job-name=DataPreProcessing
#SBATCH --output=job.%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --partition=C032M0512G
#SBATCH --qos=high
#SBATCH --constraint=ntasks-per-node=1

python -u get_pre_data_MASS.py
