#!/bin/bash
#FLUX: --job-name=ornery-squidward-7829
#FLUX: -t=1080
#FLUX: --urgency=16

module load cuda cudnn python/3.5.2
source tensorflow6/bin/activate
python /home/rbbidart/cancer_hist/src/unet_dist_test.py /home/rbbidart/project/rbbidart/cancer_hist/full_slides2 /home/rbbidart/project/rbbidart/cancer_hist/im_dist_labels /home/rbbidart/cancer_hist_out/unet_dist/unet_mid2_custom_aug_0001_2 100 4 unet_mid2
