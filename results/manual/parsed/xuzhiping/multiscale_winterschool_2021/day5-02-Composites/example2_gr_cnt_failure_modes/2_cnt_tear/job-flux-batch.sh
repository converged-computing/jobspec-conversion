#!/bin/bash
#FLUX: --job-name=cnt_tear
#FLUX: --queue=course
#FLUX: --urgency=16

module load compiles/intel/2019/u4/config
exe="/home/train1/WORK/package/lammps-stable_29Oct2020/src/lmp_mpi"
mpiexec.hydra -n 24 ${exe} < cnt_tear.in >& log
