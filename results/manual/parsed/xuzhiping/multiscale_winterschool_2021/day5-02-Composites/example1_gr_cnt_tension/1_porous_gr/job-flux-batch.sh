#!/bin/bash
#FLUX: --job-name=ex1_prs_gr
#FLUX: --queue=course
#FLUX: --urgency=16

module load compiles/intel/2019/u4/config
exe="/home/train1/WORK/package/lammps-stable_29Oct2020/src/lmp_mpi"
mpiexec.hydra -n 28 ${exe} < porous_gr.in >& log
gnuplot < plot.plt
