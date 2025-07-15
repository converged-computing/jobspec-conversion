#!/bin/bash
#FLUX: --job-name=lammps
#FLUX: -N=8
#FLUX: -t=14400
#FLUX: --priority=16

source /scratch/work/courses/CHEM-GA-2671-2022fa/software/lammps-gcc-30Oct2022/setup_lammps.bash
for i in `seq 0.8 0.1 1.5`
do
mpirun lmp -var density $i -in ../Inputs/3dWCA.in -log LOGFILE$i.log
done
mpirun lmp -var density 1 -in ../Inputs/3dWCA.in -log LOGFILE1.log
