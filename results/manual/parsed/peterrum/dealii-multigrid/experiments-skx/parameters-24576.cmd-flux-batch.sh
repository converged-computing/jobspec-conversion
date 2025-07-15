#!/bin/bash
#FLUX: --job-name=hello-lizard-7177
#FLUX: -N=512
#FLUX: --queue=general
#FLUX: -t=3600
#FLUX: --priority=16

module unload intel-mpi/2019-intel
module unload intel/19.0.5
module load gcc/9
module load intel-mpi/2019-gcc
pwd
array=($(ls input_*.json));
mpirun -np 24576 ../multigrid_throughput "${array[@]}"
