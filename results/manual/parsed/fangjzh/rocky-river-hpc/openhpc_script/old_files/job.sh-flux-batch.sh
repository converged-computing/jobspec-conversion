#!/bin/bash
#FLUX: --job-name=butterscotch-latke-7426
#FLUX: --urgency=16

mpirun   /opt/ohpc/pub/apps/lammps/lmp_mpi  -i in.lj
