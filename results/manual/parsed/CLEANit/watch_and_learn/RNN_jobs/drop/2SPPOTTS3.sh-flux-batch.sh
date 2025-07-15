#!/bin/bash
#FLUX: --job-name=wobbly-malarkey-3727
#FLUX: --queue=bumblebee
#FLUX: -t=86400
#FLUX: --priority=16

source activate tensorflow
module load cudnn/7.0-9.0
python RNN_MODELS.py drop/2SP SPIRAL POTTS1 DSIZE=512 RUNS=0 EPOCHS=20 keep_prob=0.9
