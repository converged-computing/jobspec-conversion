#!/bin/bash
#FLUX: --job-name=1AKI_50
#FLUX: -t=172800
#FLUX: --urgency=16

module purge
module load gromacs/openmpi/intel/2020.4
mpirun -np 10  gmx_mpi mdrun -deffnm md_50
