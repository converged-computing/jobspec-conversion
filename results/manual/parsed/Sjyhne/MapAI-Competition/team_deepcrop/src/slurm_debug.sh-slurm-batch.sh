#!/bin/bash
#FLUX: --job-name=seg
#FLUX: -c=4
#FLUX: --queue=ml4good
#FLUX: -t=399600
#FLUX: --urgency=16

hostname
echo $CUDA_VISIBLE_DEVICES
echo "try for using the tverskyloss"s
python train_ConvNet_aug.py --task 1 --name conv_croloss_aug --data_ratio 1.0 --config config/data_conv.yaml
