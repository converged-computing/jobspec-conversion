#!/bin/bash
#FLUX: --job-name=stinky-knife-5904
#FLUX: -t=1440
#FLUX: --urgency=16

module load cuda cudnn python/3.5.2
source tensorflow/bin/activate
python /home/rbbidart/cancer_hist/src/unet_model_test.py project/rbbidart/cancer_hist/full_slides/ project/rbbidart/cancer_hist/pixel_labels_r10 /home/rbbidart/cancer_hist/output/unet_half 100 2 half_n_half .00005
