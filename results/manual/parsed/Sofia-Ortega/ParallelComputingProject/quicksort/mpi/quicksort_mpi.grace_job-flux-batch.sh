#!/bin/bash
#FLUX: --job-name=JobName
#FLUX: -N=40
#FLUX: -t=180
#FLUX: --urgency=16

array_size=$1
processes=$2
option=$3
module load intel/2020b       # load Intel software stack
module load CMake/3.12.1
CALI_CONFIG="spot(output=p${processes}-a${array_size}-o${option}.cali, \
  time.variance)" \
mpirun -np $processes ./quicksort_mpi $array_size $option
