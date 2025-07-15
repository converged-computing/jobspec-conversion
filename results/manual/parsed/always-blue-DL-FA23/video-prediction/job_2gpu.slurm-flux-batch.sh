#!/bin/bash
#FLUX: --job-name=lovely-truffle-1445
#FLUX: -c=16
#FLUX: --exclusive
#FLUX: --queue=n1s16-v100-2
#FLUX: -t=43200
#FLUX: --priority=16

export SINGULARITY_CACHEDIR='/tmp/$USER'

mkdir /tmp/$USER
export SINGULARITY_CACHEDIR=/tmp/$USER
singularity exec --nv \
--bind /scratch \
--overlay /scratch/dnp9357/base_env/base_image.ext3:ro \
/share/apps/images/cuda11.7.99-cudnn8.5-devel-ubuntu22.04.2.sif \
/bin/bash -c "
source /ext3/env.sh
cd /home/dnp9357/video-prediction
pwd
python3 main_semseg_2.py
"
