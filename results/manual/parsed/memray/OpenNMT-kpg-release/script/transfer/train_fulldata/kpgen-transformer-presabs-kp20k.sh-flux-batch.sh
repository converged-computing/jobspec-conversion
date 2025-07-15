#!/bin/bash
#FLUX: --job-name=train-TFpresabs-kp20k
#FLUX: --queue=v100
#FLUX: -t=518400
#FLUX: --urgency=16

export CONFIG_PATH='config/transfer_kp/train/transformer-presabs-kp20k.yml'

export CONFIG_PATH="config/transfer_kp/train/transformer-presabs-kp20k.yml"
cmd="python train.py -config $CONFIG_PATH"
echo $CONFIG_PATH
echo $cmd
$cmd
