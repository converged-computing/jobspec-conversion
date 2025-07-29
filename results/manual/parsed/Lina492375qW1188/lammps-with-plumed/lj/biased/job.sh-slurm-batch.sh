#!/bin/bash
#FLUX: --job-name=lj
#FLUX: --queue=RM-shared
#FLUX: -t=600
#FLUX: --urgency=16

module load openmpi/4.0.5-gcc10.2.0
mpirun -n 1 [PATH_TO_LAMMPS_FOLDER]/lammps*/src/lmp_mpi -in inscript.in
