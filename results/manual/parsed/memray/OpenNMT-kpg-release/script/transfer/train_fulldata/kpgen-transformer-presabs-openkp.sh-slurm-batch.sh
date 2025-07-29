#!/bin/bash
#FLUX: --job-name=train-TFpresabs-openkp
#FLUX: --queue=gtx1080
#FLUX: -t=518400
#FLUX: --urgency=16

export CONFIG_PATH='config/transfer_kp/train/transformer-presabs-openkp.yml'

export CONFIG_PATH="config/transfer_kp/train/transformer-presabs-openkp.yml"
cmd="python train.py -config $CONFIG_PATH"
echo $CONFIG_PATH
echo $cmd
$cmd
