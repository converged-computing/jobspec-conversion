#!/bin/bash
#FLUX: --job-name=outstanding-itch-8030
#FLUX: --queue=express
#FLUX: -t=600
#FLUX: --urgency=16

export PATH='${PATH}:${HDF5_HOME}/bin'
export LD_LIBRARY_PATH='${LD_LIBRARY_PATH}:${HDF5_HOME}/lib'

module load hdf5-mpi
module load petsc-real 
export PATH=${PATH}:${HDF5_HOME}/bin
export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:${HDF5_HOME}/lib
srun ../../perfect -ksp_view -mat_mumps_icntl_4 2
