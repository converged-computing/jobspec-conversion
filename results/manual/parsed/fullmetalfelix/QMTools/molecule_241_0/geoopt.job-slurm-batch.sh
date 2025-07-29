#!/bin/bash
#SBATCH --job-name=go_13
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=10
#SBATCH --time=01:00:00
#SBATCH --partition=batch
#SBATCH --constraint=skl

export OMP_PROC_BIND='true'
export PSI_SCRATCH='/tmp/'

export OMP_PROC_BIND=true
export PSI_SCRATCH=/tmp/
module load anaconda3
module load iomklc/triton-2017a
module load cmake/3.12.1
srun python geoopt.py
