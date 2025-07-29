#!/bin/bash
#FLUX: --job-name=XXXXXX
#FLUX: --queue=prod
#FLUX: -t=43200
#FLUX: --urgency=16

module load openmpi
module load gromacs/5.1.4-single
mpirun gmx_mpi mdrun -deffnm XXXXXX
