#!/bin/bash
#FLUX: --job-name=seg
#FLUX: -c=4
#FLUX: -t=399600
#FLUX: --urgency=16

hostname
echo $CUDA_VISIBLE_DEVICES
echo "try for using the tverskyloss"s
python train_ConvNet.py --task 1 --name convNext_croloss --data_ratio 1.0 --config config/data_conv.yaml --lr 1e-2
