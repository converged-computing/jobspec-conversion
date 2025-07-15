#!/bin/bash
#FLUX: --job-name=train-tf-DA-kptimes
#FLUX: --queue=titanx
#FLUX: -t=518400
#FLUX: --urgency=16

export CONFIG_PATH='script/transfer/train_tf_DA/transformer-DA-kptimes.yml'

export CONFIG_PATH="script/transfer/train_tf_DA/transformer-DA-kptimes.yml"
cmd="python train.py -config $CONFIG_PATH"
echo $CONFIG_PATH
echo $cmd
$cmd
