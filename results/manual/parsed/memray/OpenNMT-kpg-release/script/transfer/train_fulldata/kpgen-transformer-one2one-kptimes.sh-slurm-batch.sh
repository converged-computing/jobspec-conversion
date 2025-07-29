#!/bin/bash
#FLUX: --job-name=train-TF-one2one-kptimes
#FLUX: --queue=gtx1080
#FLUX: -t=259200
#FLUX: --urgency=16

export CONFIG_PATH='config/transfer_kp/train/transformer-one2one-kptimes.yml'

export CONFIG_PATH="config/transfer_kp/train/transformer-one2one-kptimes.yml"
cmd="python train.py -config $CONFIG_PATH"
echo $CONFIG_PATH
echo $cmd
$cmd
