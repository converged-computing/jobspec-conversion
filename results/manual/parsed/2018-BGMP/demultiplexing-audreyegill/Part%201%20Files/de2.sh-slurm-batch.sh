#!/bin/bash
#SBATCH --job-name=DM_2
#SBATCH --output=slurm-%j-%x
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:10:00
#SBATCH --partition=short
#SBATCH --constraint=ntasks-per-node=14

ml easybuild intel/2017a Python/3.6.1
./pt_one2.py
