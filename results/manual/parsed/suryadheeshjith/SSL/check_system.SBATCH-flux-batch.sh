#!/bin/bash
#FLUX: --job-name=fat-spoon-2196
#FLUX: -c=8
#FLUX: --exclusive
#FLUX: --queue=n1s8-v100-1
#FLUX: -t=43200
#FLUX: --urgency=16

singularity exec --nv --overlay overlay-15GB-500K.ext3:ro\
    -B data/dataset_v2.sqsh:/dataset:image-src=/\
    -B /scratch\
    /share/apps/images/cuda11.7.99-cudnn8.5-devel-ubuntu22.04.2.sif\
   /bin/bash -c 'source /ext3/env.sh; python check_system.py'
