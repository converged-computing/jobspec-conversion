#!/bin/bash
#FLUX: --job-name=dinosaur-noodle-7802
#FLUX: -t=172800
#FLUX: --priority=16

source /home/jc3/miniconda2/etc/profile.d/conda.sh
conda activate pytorch-0.4.1
module load gcc
module load cuda
sh run_r_101_d_8_ocrnet_train_contrast.sh train 'resnet101-ocr-contrast-40k'
