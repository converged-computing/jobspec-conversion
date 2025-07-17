#!/bin/bash
#FLUX: --job-name=train-2048-mamba
#FLUX: -c=16
#FLUX: --queue=GPU
#FLUX: -t=86400
#FLUX: --urgency=16

module load singularity
singularity exec --nv nvidia.sif bash -c "$(cat $JOB_NAME.sh)"
