#!/bin/bash
#FLUX: --job-name=LAMMPS_provisional
#FLUX: -N=2
#FLUX: --queue=k40
#FLUX: --urgency=16

ml purge
ml intel
ml mkl
mpirun -np 56 lammps-patch_10Mar2021/src/lmp_intel_cpu_intelmpi -in in.lj.txt -pk intel 0 omp 1 -sf intel
