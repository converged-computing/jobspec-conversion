#!/bin/bash
#FLUX: --job-name=run-gromacs
#FLUX: -t=57600
#FLUX: --priority=16

module purge
module load gromacs/openmpi/intel/2020.4
mpirun gmx_mpi  mdrun -deffnm md_0_1
