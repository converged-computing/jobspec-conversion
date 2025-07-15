#!/bin/bash
#FLUX: --job-name=CA_EX8_stream
#FLUX: --exclusive
#FLUX: --priority=16

set -x
set -v
module load intel
echo "ArraySize,MegaUpdatesPerSecond,ActualRuntime,MinimalRuntime,EdgeSize" > result_cb_xy.csv
srun ../bin/jacobi 512 1000 >> result_cb_xy.csv
touch ready
