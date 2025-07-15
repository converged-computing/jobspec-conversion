#!/bin/bash
#FLUX: --job-name=hello-hope-9345
#FLUX: -c=8
#FLUX: --exclusive
#FLUX: --queue=n1s8-v100-1
#FLUX: -t=25200
#FLUX: --priority=16

singularity exec --bind /scratch/ak11089 --nv --overlay /scratch/ak11089/final-project/overlay-50G-10M.ext3:ro /share/apps/images/cuda11.7.99-cudnn8.5-devel-ubuntu22.04.2.sif /bin/bash -c "
source /ext3/activate_conda.sh
cd /scratch/ak11089/final-project/Deep-Learning-Project-Fall-23/src/mcvd
sh src/mcvd/train.sh
"
