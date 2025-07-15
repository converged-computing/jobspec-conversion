#!/bin/bash
#FLUX: --job-name=tart-spoon-9982
#FLUX: -N=2
#FLUX: --priority=16

module add openmpi/4.1.1
cd /mnt/orangefs/hacker/genie-lammps/tweak_lammps
mpirun -np 4 /software/lammps/lammps-23Jun2022/src/lmp_mpi -in test-input.txt
