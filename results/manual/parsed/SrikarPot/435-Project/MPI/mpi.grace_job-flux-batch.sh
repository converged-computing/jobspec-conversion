#!/bin/bash
#FLUX: --job-name=JobName
#FLUX: -t=1800
#FLUX: --urgency=16

algo=$1
processes=$2
num_vals=$3
input_type=$4
module load intel/2020b       # load Intel software stack
module load CMake/3.12.1
echo "algo: $algo, processes: $processes, num_vals: $num_vals, input_type: $input_type"
CALI_CONFIG="spot(output=${algo}MPI-p${processes}-v${num_vals}-t${input_type}.cali, \
    time.variance)" \
mpirun -np $processes ./$algo $num_vals $input_type
