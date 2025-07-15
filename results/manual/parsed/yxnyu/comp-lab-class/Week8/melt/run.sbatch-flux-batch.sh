#!/bin/bash
#FLUX: --job-name=lammps
#FLUX: -N=8
#FLUX: -t=14400
#FLUX: --priority=16

source /scratch/work/courses/CHEM-GA-2671-2022fa/software/lammps-gcc-30Oct2022/setup_lammps.bash
mpirun lmp -in in.melt -log LOGFILE
