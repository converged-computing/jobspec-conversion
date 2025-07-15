#!/bin/bash
#FLUX: --job-name=strawberry-butter-8789
#FLUX: --priority=16

module load python-env/3.6.3-ml
module list
set -xv
mpirun -np 4 -bind-to none -map-by slot \
    -x NCCL_DEBUG=INFO -x LD_LIBRARY_PATH -x PATH \
    -mca pml ob1 -mca btl ^openib -oversubscribe \
    python3.6 $*
