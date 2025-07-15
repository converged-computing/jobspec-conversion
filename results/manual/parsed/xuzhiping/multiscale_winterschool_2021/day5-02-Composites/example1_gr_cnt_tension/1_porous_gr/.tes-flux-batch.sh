#!/bin/bash
#FLUX: --job-name=delicious-pedo-8376
#FLUX: --urgency=16

module load compiles/intel/2019/u4/config
exe="/apps/soft/lammps/lammps-7Aug19/e5_2680v4/opa/lammps-7Aug19/src/lmp_mpi"
exe="/home/train1/WORK/package/lammps-stable_29Oct2020/src/lmp_mpi"
mpirun -np 4 ${exe} < porous_gr.in 
