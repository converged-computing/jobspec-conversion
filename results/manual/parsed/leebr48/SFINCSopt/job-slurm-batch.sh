#!/bin/bash
#SBATCH --job-name=sfincsOpt
#SBATCH --output=./sfincsOpt.out.%j
#SBATCH --error=./sfincsOpt.err.%j
#SBATCH --mail-user=brandon.lee@ipp.mpg.de
#SBATCH --mail-type=all
#SBATCH --nodes=18
#SBATCH --ntasks=720
#SBATCH --cpus-per-task=1
#SBATCH --time=1-00:00:00
#SBATCH --chdir=./

module purge
module load intel/19.1.2
module load mkl/2020.4
module load impi/2019.8
module load hdf5-mpi/1.8.22
module load netcdf-mpi/4.4.1
module load fftw-mpi
module load anaconda/3/2020.02
module load petsc-real/3.13.5
module load mumps-32-noomp/5.1.2
module load gcc/11
python main.py
