#!/bin/bash
#FLUX: --job-name=JobName
#FLUX: -t=1800
#FLUX: --urgency=16

array_size=$1
processes=$2
module load intel/2020b       # load Intel software stack
module load CMake/3.12.1
CALI_CONFIG="spot(output=p${processes}-a${array_size}.cali, \
    time.variance)" \
mpirun -np $processes ./OddEvenSort $array_size
