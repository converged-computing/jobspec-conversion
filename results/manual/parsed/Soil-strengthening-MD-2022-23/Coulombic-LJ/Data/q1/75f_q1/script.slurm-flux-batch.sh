#!/bin/bash
#FLUX: --job-name=75f_q1
#FLUX: -N=8
#FLUX: -t=172800
#FLUX: --priority=16

module load shared
module load mvapich2/gcc/64/2.2rc1
module load lammps/gcc/3Mar2020-bigbig
cd $HOME/75f_q1
mpirun lmp_bigbig < hydrogel_test.in > output.txt 
