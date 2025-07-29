#!/bin/bash
#FLUX: --job-name=JobName
#FLUX: -N=16
#FLUX: -t=1800
#FLUX: --urgency=16

processes=$1
array_size=$2
option=$3
module load intel/2020b       # load Intel software stack
module load CMake/3.12.1
CALI_CONFIG="spot(output=outputs/perturbed/p${processes}/bitonic_mpi_p${processes}-a${array_size}_${option}.cali, \
    time.variance)" \
mpirun -np $processes ./bitonic_mpi $array_size $option
