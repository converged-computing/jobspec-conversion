#!/bin/bash
#FLUX: --job-name=JobName
#FLUX: -t=1800
#FLUX: --urgency=16

processes=$1
size=$2
option=$3
module load intel/2020b       # load Intel software stack
module load CMake/3.12.1
CALI_CONFIG="spot(output=mpi_cali/p${processes}-a${size}-option${option}.cali, \
    time.variance)" \
mpirun -n $processes ./bitonic $size $option
