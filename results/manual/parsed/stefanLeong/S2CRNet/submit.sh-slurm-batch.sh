#!/bin/bash
#FLUX: --job-name=torch
#FLUX: --queue=gpu-normal
#FLUX: -t=259200
#FLUX: --urgency=16

source /etc/profile
source /etc/profile.d/modules.sh
module add singularity/2.6.1
module add cuda/10.0.130
ulimit -s unlimited
singularity exec --nv --bind /data:/data /share/apps/singularity/simg/pytorch/miniconda3-pytorch bash -c "bash ./train.sh"
