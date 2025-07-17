#!/bin/bash
#FLUX: --job-name=persnickety-chip-6885
#FLUX: -N=2
#FLUX: --urgency=16

module add openmpi/4.1.1
cd /mnt/orangefs/hacker/genie-lammps/tweak_lammps
mpirun -np 4 /software/lammps/lammps-23Jun2022/src/lmp_mpi -in test-input.txt
