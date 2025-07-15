#!/bin/bash
#FLUX: --job-name=taming
#FLUX: -c=8
#FLUX: --queue=n1c24m128-v100-4
#FLUX: -t=14400
#FLUX: --priority=16

module purge
singularity exec --nv --overlay /scratch/jq394/imageTokenizer/taming.ext3:ro /share/apps/images/cuda11.7.99-cudnn8.5-devel-ubuntu22.04.2.sif /bin/bash -c "source /ext3/env.sh; conda activate taming; bash train_taming.sh"
