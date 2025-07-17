#!/bin/bash
#FLUX: --job-name=gloopy-mango-0900
#FLUX: -t=720
#FLUX: --urgency=16

module load cuda cudnn python/3.5.2
source tensorflow/bin/activate
python /home/rbbidart/cancer_hist/src/train_models_k.py /home/rbbidart/project/rbbidart/breakHis/mkfold_keras_8/fold1 /home/rbbidart/breakHis/output/vgg16_fc1_8 100 8 vgg16_fc1 100 8
