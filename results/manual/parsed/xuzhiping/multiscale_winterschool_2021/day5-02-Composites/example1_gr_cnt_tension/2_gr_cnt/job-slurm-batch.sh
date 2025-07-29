#!/bin/bash
#FLUX: --job-name=ex1_gr_cnt
#FLUX: --queue=course
#FLUX: --urgency=16

module load compiles/intel/2019/u4/config
exe="/home/train1/WORK/package/lammps-stable_29Oct2020/src/lmp_mpi"
mpiexec.hydra -n 24 ${exe} < gr_cnt.in  >& log
gnuplot < plot.plt
