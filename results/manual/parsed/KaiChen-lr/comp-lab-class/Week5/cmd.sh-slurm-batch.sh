#!/bin/bash
#FLUX: --job-name=npt
#FLUX: -t=144000
#FLUX: --urgency=16

module purge
module load gromacs/openmpi/intel/2020.4
mpirun gmx_mpi mdrun -deffnm md_0_1
