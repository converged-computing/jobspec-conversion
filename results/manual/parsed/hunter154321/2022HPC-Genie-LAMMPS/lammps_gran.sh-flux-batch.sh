#!/bin/bash
#FLUX: --job-name=pusheena-animal-1298
#FLUX: -N=2
#FLUX: --urgency=16

module add openmpi/4.1.2
cd /mnt/orangefs/hacker/genie-lammps
mpirun -np 4 /software/lammps/lammps-23Jun2022/src/lmp_mpi -in in.chute.txt
