#!/bin/bash
#SBATCH --job-name=CORIE
#SBATCH --account=nos-surge
#SBATCH --output=myout
#SBATCH --error=err2.out
#SBATCH --mail-user=yjzhang@vims.edu
#SBATCH --mail-type=all
#SBATCH --nodes=2
#SBATCH --ntasks=80
#SBATCH --cpus-per-task=1
#SBATCH --time=02:00:00
#SBATCH --partition=orion
#SBATCH: --exclusive
#SBATCH --chdir=.

set -e
ulimit -s unlimited 
module load intel/2020 impi/2020 netcdf/4.7.2-parallel
srun ./pschism_ORION_TVD-VL 8
