#!/bin/bash
#FLUX: --job-name=faux-latke-2743
#FLUX: -c=24
#FLUX: -t=84600
#FLUX: --urgency=16

export MODULEPATH='/mnt/home/gkrawezik/modules/rocky8:$MODULEPATH'

module purge
export MODULEPATH=/mnt/home/gkrawezik/modules/rocky8:$MODULEPATH
module load modules/2.1 cuda/12.0 cudnn/cuda12-8.8.0
source ~/envs/score_pytorch_h100/bin/activate
python train.py
