#!/bin/bash
#FLUX: --job-name=lammps-NEB1
#FLUX: --queue=course
#FLUX: --urgency=16

module load compiles/intel/2019/u4/config
module load lib/gcc/9.2.0/config
mpirun -n 24 /home/train1/WORK/package/lammps-stable_29Oct2020/src/lmp_mpi -partition 12x2 -in in.neb.hop1 >log
