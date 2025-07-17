#!/bin/bash
#FLUX: --job-name=JobName
#FLUX: -t=180
#FLUX: --urgency=16

array_size=$1
processes=$2
input_type=$3
module load intel/2020b       # load Intel software stack
module load CMake/3.12.1
CALI_CONFIG="spot(output=outs/reverse/p${processes}/sample_mpi_p${processes}-a${array_size}_${input_type}.cali, \
    time.variance)" \
mpirun -np $processes ./sample_mpi $array_size $input_type
