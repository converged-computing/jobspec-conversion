#!/bin/bash
#FLUX: --job-name=blank-cupcake-0260
#FLUX: --priority=16

module load oneapi/2021
KMP_BLOCKTIME=0 mpirun -n 80 singularity run $YOUR_IMAGE_PATH  lmp -i in.eam
