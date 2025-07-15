#!/bin/bash
#FLUX: --job-name=dinosaur-carrot-9143
#FLUX: -c=16
#FLUX: --queue=gpu-h100
#FLUX: -t=345600
#FLUX: --urgency=16

module unload CUDA/11.7.0
module unload cuDNN/8.4.1.50-CUDA-11.7.0
module load Anaconda3/2022.10 binutils/2.31.1-GCCcore-8.2.0 CUDA/11.8.0 cuDNN/8.6.0.163-CUDA-11.8.0 GCCcore/8.2.0
source activate /mnt/parscratch/users/acp21rjf/env/h100/
python train_meta.py -config ./configs/meta_test.yaml
