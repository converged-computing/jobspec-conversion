#!/bin/bash
#FLUX: --job-name=eccentric-banana-0341
#FLUX: -c=8
#FLUX: --exclusive
#FLUX: --queue=n1s8-v100-1
#FLUX: -t=43200
#FLUX: --urgency=16

export SINGULARITY_CACHEDIR='/tmp/$USER'

mkdir /tmp/$USER
export SINGULARITY_CACHEDIR=/tmp/$USER
echo '1gpu'
singularity exec --nv \
--bind /scratch \
--overlay /scratch/dnp9357/base_env/base_image.ext3:ro \
/share/apps/images/cuda11.7.99-cudnn8.5-devel-ubuntu22.04.2.sif \
/bin/bash -c "
source /ext3/env.sh
cd /home/dnp9357/video-prediction
pwd
python3 Hidden_dataset.py
"
