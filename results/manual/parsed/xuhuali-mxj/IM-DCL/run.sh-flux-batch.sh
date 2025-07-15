#!/bin/bash
#FLUX: --job-name=xu
#FLUX: -c=32
#FLUX: --queue=gpusmall
#FLUX: -t=3600
#FLUX: --priority=16

$SCRATCH
module load pytorch/1.10
srun nvidia-smi
python ./adapt_da.py --model ResNet10 --train_aug --use_saved --dtarget CropDisease --n_shot 1
