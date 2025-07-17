#!/bin/bash
#FLUX: --job-name=GSF_Cu
#FLUX: --queue=course
#FLUX: --urgency=16

module load compiles/intel/2019/u4/config
module load lib/gcc/9.2.0/config
mpiexec.hydra -n 4 /home/train1/WORK/package/lammps-stable_29Oct2020/src/lmp_mpi  < gsf.in > gsf_Cu.log
