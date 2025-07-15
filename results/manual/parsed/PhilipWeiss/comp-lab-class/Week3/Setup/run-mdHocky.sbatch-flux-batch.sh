#!/bin/bash
#FLUX: --job-name=mdrun
#FLUX: -t=36000
#FLUX: --priority=16

module purge
module load gromacs/openmpi/intel/2020.4
gmx_mpi mdrun -deffnm md_0_1
