#!/bin/bash
#FLUX: --job-name=fat-puppy-0553
#FLUX: -t=1440
#FLUX: --urgency=16

module load cuda cudnn python/3.5.2
source tensorflow/bin/activate
python /home/rbbidart/cancer_hist/src/gen_heatmaps_fc.py project/rbbidart/cancer_hist/full_slides project/rbbidart/cancer_hist/heat_conv_incp3_128 /home/rbbidart/cancer_hist/output/size128_class/conv_incp3_128_.46-0.91.hdf5 128 2
