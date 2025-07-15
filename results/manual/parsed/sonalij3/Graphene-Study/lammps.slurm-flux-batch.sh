#!/bin/bash
#FLUX: --job-name="8024_C-1100K"
#FLUX: -t=172800
#FLUX: --priority=16

echo
echo "Begin job ..."
date
echo
module load openmpi
mpirun -np 16 ../downloads/lammps-29Sep2021/src/lmp_mpi -in graphene_single_layer_ReaxFF_8024_C.input 
echo
echo "End of job ..."
date
echo
