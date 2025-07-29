#!/bin/bash
#SBATCH --job-name=dgr
#SBATCH --output=.dgr.o%j
#SBATCH --error=.dgr.e%j
#SBATCH --nodes=2
#SBATCH --ntasks=256
#SBATCH --cpus-per-task=1
#SBATCH --time=01:30:00
#SBATCH --partition=normal

module list
pwd
date
make bssnSolverCtx -j4
ibrun ./BSSN_GR/bssnSolverCtx q1_r2.2.par.json 1
