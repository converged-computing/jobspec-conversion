#!/bin/bash
#FLUX: --job-name=astute-platanos-2343
#FLUX: -n=4
#FLUX: -c=6
#FLUX: --queue=gpu
#FLUX: -t=3600
#FLUX: --urgency=16

module load python-env/3.6.3-ml
module list
set -xv
mpirun -np 4 -bind-to none -map-by slot \
    -x NCCL_DEBUG=INFO -x LD_LIBRARY_PATH -x PATH \
    -mca pml ob1 -mca btl ^openib -oversubscribe \
    python3.6 $*
