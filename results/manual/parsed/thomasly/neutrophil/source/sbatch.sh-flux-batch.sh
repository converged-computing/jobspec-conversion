#!/bin/bash
#FLUX: --job-name=tensorflow
#FLUX: --queue=gpu4_medium
#FLUX: --urgency=16

module purge
module load python/gpu/3.6.5
wait
python train_resnet.py 1 32 100 0
