#!/bin/bash
#FLUX: --job-name=run-gromacs
#FLUX: -t=86400
#FLUX: --priority=16

module purge
module load gromacs/openmpi/intel/2020.4
mpirun -np 1 gmx_mpi mdrun -deffnm npt_eq
