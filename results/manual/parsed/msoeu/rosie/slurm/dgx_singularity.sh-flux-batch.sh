#!/bin/bash
#FLUX: --job-name="DGX 8 GPU"
#FLUX: --queue=dgx
#FLUX: --priority=16

SCRIPT_NAME="Rosie DGX Script"
CONTAINER="/data/containers/msoe-tensorflow.sif"
SCRIPT_PATH=""
SCRIPT_ARGS=""
echo "SBATCH SCRIPT: ${SCRIPT_NAME}"
srun hostname; pwd; date;
srun singularity exec --nv -B /data:/data ${CONTAINER} python3 ${SCRIPT_PATH} ${SCRIPT_ARGS}
echo "END: " $SCRIPT_NAME
