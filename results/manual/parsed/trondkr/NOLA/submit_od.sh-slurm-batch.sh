#!/bin/bash
#SBATCH --job-name=kvile_od
#SBATCH --account=nn8103k
#SBATCH --nodes=10
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=4-12:00:00
#SBATCH --constraint=ntasks-per-node=32

set -o errexit # Make bash exit on any error
set -o nounset # Treat unset variables as errors
module list  
echo 1+1
time /cluster/projects/nn8103k/NIVA-NOLA/opendrift_latest.sif python run_od_norkyst.py
exit 0
