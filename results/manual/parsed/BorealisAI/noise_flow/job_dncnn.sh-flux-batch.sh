#!/bin/bash
#FLUX: --job-name=dncnn_nf
#FLUX: --urgency=16

hostname
whoami
python train_dncnn_noiseflow.py \
        --model DnCNN_Gauss \
        --train_data '/home/abdo/Downloads/SIDD_Medium_Raw/Data' \
        --save_every 20 \
        --max_epoch 2000 \
        --num_gpus 1
