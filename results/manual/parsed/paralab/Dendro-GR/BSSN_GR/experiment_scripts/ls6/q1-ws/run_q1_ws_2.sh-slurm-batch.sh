#!/bin/bash
#SBATCH --job-name=dgr
#SBATCH --output=.dgr.o%j
#SBATCH --error=.dgr.e%j
#SBATCH --nodes=1
#SBATCH --ntasks=2
#SBATCH --cpus-per-task=1
#SBATCH --time=01:30:00

module list
pwd
date
make bssnWSTestCUDA -j4
ibrun ./BSSN_GR/bssnWSTestCUDA q1_ws.par.json 1
