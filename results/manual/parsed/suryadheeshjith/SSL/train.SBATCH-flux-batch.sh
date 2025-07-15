#!/bin/bash
#FLUX: --job-name=swampy-itch-1166
#FLUX: -c=24
#FLUX: --exclusive
#FLUX: --queue=n1c24m128-v100-4
#FLUX: -t=43200
#FLUX: --urgency=16

singularity exec --nv --overlay overlay-15GB-500K.ext3:ro\
    -B data/dataset_v2.sqsh:/dataset:image-src=/\
    -B /scratch\
    /share/apps/images/cuda11.7.99-cudnn8.5-devel-ubuntu22.04.2.sif\
   /bin/bash -c 'source /ext3/env.sh; python train.py'
