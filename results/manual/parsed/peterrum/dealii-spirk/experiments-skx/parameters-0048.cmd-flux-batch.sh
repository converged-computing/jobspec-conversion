#!/bin/bash
#FLUX: --job-name=bloated-spoon-6761
#FLUX: --queue=micro
#FLUX: -t=1800
#FLUX: --priority=16

module unload intel-mpi/2019-intel
module unload intel/19.0.5
module load gcc/9
module load intel-mpi/2019-gcc
pwd
array=($(ls input_*.json));
mpirun -np 48 ../irk-3D "${array[@]}"
