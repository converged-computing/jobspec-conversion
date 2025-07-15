#!/bin/bash
#FLUX: --job-name=wobbly-butter-6604
#FLUX: --priority=16

module load compiles/intel/2019/u4/config
module load lib/gcc/9.2.0/config
mpiexec.hydra -n 4 /home/train1/WORK/package/lammps-stable_29Oct2020/src/lmp_mpi  <input.in >log
