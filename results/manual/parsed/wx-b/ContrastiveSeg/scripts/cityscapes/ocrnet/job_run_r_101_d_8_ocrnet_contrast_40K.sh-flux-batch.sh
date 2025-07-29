#!/bin/bash
#FLUX --job-name=sticky-citrus-4170
#FLUX -n=40
#FLUX -t=172800
#FLUX --urgency=16

source /home/jc3/miniconda2/etc/profile.d/conda.sh
conda activate pytorch-0.4.1
module load gcc
module load cuda
sh run_r_101_d_8_ocrnet_train_contrast.sh train 'resnet101-ocr-contrast-40k'
