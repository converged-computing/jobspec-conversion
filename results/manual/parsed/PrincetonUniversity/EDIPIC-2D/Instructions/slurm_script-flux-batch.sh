#!/bin/bash
#FLUX: --job-name=frigid-arm-5529
#FLUX: -n=96
#FLUX: -t=14400
#FLUX: --priority=16

export PETSC_DIR='/scratch/gpfs/ethier/STELLAR/Software/INTEL_MPI_2021'
export LD_LIBRARY_PATH='${PETSC_DIR}/lib:${LD_LIBRARY_PATH}'

module load intel/2021.1.2
module load intel-mpi/intel/2021.3.1
export PETSC_DIR=/scratch/gpfs/ethier/STELLAR/Software/INTEL_MPI_2021
export LD_LIBRARY_PATH=${PETSC_DIR}/lib:${LD_LIBRARY_PATH}
srun -n 96 ./edipic2d >& output.log
