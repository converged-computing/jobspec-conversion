#!/bin/bash
#FLUX: --job-name=run_md
#FLUX: -t=86400
#FLUX: --urgency=16

module purge
module load gromacs/openmpi/intel/2020.4
mpirun gmx_mpi mdrun -deffnm ../Setup/md_0_1
