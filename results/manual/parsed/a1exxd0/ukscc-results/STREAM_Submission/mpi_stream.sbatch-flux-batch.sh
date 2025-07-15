#!/bin/bash
#FLUX: --job-name=stream4
#FLUX: -N=4
#FLUX: -c=16
#FLUX: -t=300
#FLUX: --urgency=16

module load compilers/armclang/24.04
module load libraries/openmpi/5.0.3/armclang-24.04
OMP_NUM_THREADS=16
mpirun -np 4 -map-by node ./STREAM/mpi_stream
