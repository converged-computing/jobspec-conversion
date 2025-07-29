#!/bin/bash
#SBATCH --job-name=uv-coverage
#SBATCH --account=Pra17_4382
#SBATCH --output=msg/uv-out.%j
#SBATCH --error=msg/uv-err.%j
#SBATCH --mail-user=mb756@sussex.ac.uk
#SBATCH --mail-type=ALL
#SBATCH --nodes=10
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=1-00:00:00
#SBATCH --partition=gll_usr_prod
#SBATCH --constraint=ntasks-per-node=26

module load intel intelmpi
module load profile/base autoload python/3.6.4
module load profile/base autoload fftw
module load profile/base autoload gsl
mpiexec -n ${SLURM_NPROCS} python create_uvcoverage_mpi.py
