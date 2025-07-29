#!/bin/bash
#FLUX: --job-name=JobName
#FLUX: -N=8
#FLUX: -t=1800
#FLUX: --urgency=16

input_type=$1
processes=$2
input_size=$3
module load intel/2020b       # load Intel software stack
module load CMake/3.12.1
CALI_CONFIG="spot(output=SS-MPI-i${input_type}-p${processes}-s${input_size}.cali, \
    time.variance)" \
mpirun -np $processes ../../../Sample_Sort $input_type $processes $input_size
