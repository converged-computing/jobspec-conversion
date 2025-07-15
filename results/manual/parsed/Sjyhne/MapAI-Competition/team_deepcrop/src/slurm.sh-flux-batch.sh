#!/bin/bash
#FLUX: --job-name=seg
#FLUX: -c=4
#FLUX: -t=399600
#FLUX: --urgency=16

hostname
echo $CUDA_VISIBLE_DEVICES
python train.py --task 2 --name deeplabv3_resnet50_withpreweight_combine_lidar --data_ratio 1.0
