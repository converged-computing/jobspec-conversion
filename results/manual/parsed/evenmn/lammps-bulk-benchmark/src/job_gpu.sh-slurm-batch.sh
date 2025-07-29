#!/bin/bash
#FLUX: --job-name=test
#FLUX: -c=2
#FLUX: --queue=normal
#FLUX: --urgency=16

mpirun -n 1 lmp_test -pk kokkos newton on neigh full -k on g 1 -sf kk -in in.lammps
