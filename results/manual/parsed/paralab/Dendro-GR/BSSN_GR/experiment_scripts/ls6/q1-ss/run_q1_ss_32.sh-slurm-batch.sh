#!/bin/bash
#SBATCH --job-name=dgr
#SBATCH --output=.dgr.o%j
#SBATCH --error=.dgr.e%j
#SBATCH --nodes=16
#SBATCH --ntasks=32
#SBATCH --cpus-per-task=1
#SBATCH --time=01:30:00
#SBATCH --partition=gpu-a100

module list
pwd
date
make bssnSolverCUDA -j4
ibrun ./BSSN_GR/bssnSolverCUDA q1_r2.2.par.json 1
