#!/bin/bash
#FLUX: --job-name="npt"
#FLUX: -t=144000
#FLUX: --priority=16

module purge
module load gromacs/openmpi/intel/2018.3
mpirun -np 1 gmx_mpi mdrun -deffnm adp
