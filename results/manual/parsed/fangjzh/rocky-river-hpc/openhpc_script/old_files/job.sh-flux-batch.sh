#!/bin/bash
#FLUX: --job-name=swampy-eagle-6987
#FLUX: --priority=16

mpirun   /opt/ohpc/pub/apps/lammps/lmp_mpi  -i in.lj
