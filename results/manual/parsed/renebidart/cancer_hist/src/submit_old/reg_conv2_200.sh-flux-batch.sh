#!/bin/bash
#FLUX: --job-name=expensive-diablo-2413
#FLUX: -t=1380
#FLUX: --urgency=16

module load cuda cudnn python/3.5.2
source tensorflow/bin/activate
python /home/rbbidart/cancer_hist/src/reg_test.py project/rbbidart/cancer_hist/full_slides /home/rbbidart/cancer_hist/output/reg_conv2_200 200 8 200 conv2
