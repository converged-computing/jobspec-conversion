#!/bin/bash
#SBATCH --job-name=txtbak
#SBATCH --account=hpc0006177081
#SBATCH --output=slurm-%j-%N.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --qos=low
#SBATCH --constraint=ntasks-per-node=32

module load anaconda/2-4.4.0.1
python  txtbak.py
