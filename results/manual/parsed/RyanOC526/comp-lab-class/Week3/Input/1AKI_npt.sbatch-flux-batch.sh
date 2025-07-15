#!/bin/bash
#FLUX: --job-name=1AKI_nvt
#FLUX: -t=14400
#FLUX: --priority=16

module purge
module load gromacs/openmpi/intel/2020.4
mpirun gmx_mpi mdrun -v -deffnm npt
