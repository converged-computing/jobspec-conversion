#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=8
#SBATCH --cpus-per-task=1
#SBATCH --time=06:00:00
#SBATCH --partition=cpu

module purge
module load GCC/11.2.0 
module list
CLUSTER=vega_ucxonly make info
CLUSTER=vega_ucxonly make install
