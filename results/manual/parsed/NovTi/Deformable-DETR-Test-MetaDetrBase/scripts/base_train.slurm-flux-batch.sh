#!/bin/bash
#FLUX: --job-name=base_train
#FLUX: -c=2
#FLUX: --queue=v100
#FLUX: -t=100800
#FLUX: --urgency=16

config_path=$1
ext3_path=/scratch/$USER/py39/overlay-25GB-500K.ext3
sif_path=/scratch/$USER/cuda11.4.2-cudnn8.2.4-devel-ubuntu20.04.3.sif
singularity exec --nv --overlay ${ext3_path}:ro ${sif_path} \
/bin/bash -c "
source /ext3/env.sh
cd /scratch/$USER/Deformable-DETR-Test
python -m main --config ${config_path}
"
