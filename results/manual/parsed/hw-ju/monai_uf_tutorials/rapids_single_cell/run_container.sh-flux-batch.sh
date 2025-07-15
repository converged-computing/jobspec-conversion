#!/bin/bash
#FLUX: --job-name=lovely-arm-7390
#FLUX: -c=2
#FLUX: --queue=gpu
#FLUX: -t=7200
#FLUX: --priority=16

date;hostname;pwd
module load singularity
singularity run --nv \
--bind /blue/vendor-nvidia/hju/single_cell_data:/data \
/blue/vendor-nvidia/hju/single-cell-examples_rapids_cuda11.0
