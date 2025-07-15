#!/bin/bash
#FLUX: --job-name=melt
#FLUX: -t=144000
#FLUX: --urgency=16

source /scratch/work/courses/CHEM-GA-2671-2022fa/software/lammps-gcc-30Oct2022/setup_lammps.bash
for i in 0.95;
do
mpirun lmp -var density $i -in ../Inputs/2dWCA.in -log density_$i.log ;
done
