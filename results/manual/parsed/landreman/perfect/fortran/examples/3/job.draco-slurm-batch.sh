#!/bin/bash
#SBATCH --job-name=perfect
#SBATCH --output=./perfectJob.out.%j
#SBATCH --error=./perfectJob.err.%j
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:10:00
#SBATCH --partition=express
#SBATCH --constraint=ntasks-per-node=3
#SBATCH --chdir=./

export PATH='${PATH}:${HDF5_HOME}/bin'
export LD_LIBRARY_PATH='${LD_LIBRARY_PATH}:${HDF5_HOME}/lib'

module load hdf5-mpi
module load petsc-real 
export PATH=${PATH}:${HDF5_HOME}/bin
export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:${HDF5_HOME}/lib
srun ../../perfect -ksp_view -mat_mumps_icntl_4 2
