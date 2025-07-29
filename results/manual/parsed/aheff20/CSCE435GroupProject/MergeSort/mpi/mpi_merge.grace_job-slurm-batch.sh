#!/bin/bash
#FLUX: --job-name=JobName
#FLUX: -N=2
#FLUX: -t=1800
#FLUX: --urgency=16

array_size=$1
processes=$2
type=$3
module load intel/2020b       # load Intel software stack
module load CMake/3.12.1
CALI_CONFIG="spot(output=cali_recent_2/p${processes}-a${array_size}-t${type}.cali, \
    time.variance)" \
mpirun -np $processes ./merge_mpi $array_size $type
