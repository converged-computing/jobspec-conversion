#!/bin/bash
#FLUX: --job-name=JobName
#FLUX: -t=1800
#FLUX: --urgency=16

num_vals=$1
processes=$2
module load intel/2020b       # load Intel software stack
module load CMake/3.12.1
CALI_CONFIG="spot(output=${processes}-${num_vals}.cali, \
  time.variance)" \
mpirun -np $processes ./radixmpi $num_vals 0
