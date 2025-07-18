#!/bin/bash
#FLUX: --job-name=lmps
#FLUX: -n=14
#FLUX: --queue=mit
#FLUX: -t=172800
#FLUX: --urgency=16

module load gcc
module add mvapich2/gcc
lammpsdir="../LAMMPS-PreGenome/src/"
mpirun -np 14 $lammpsdir/lmp_openmpi -in in.chromosome
