#!/bin/bash
#FLUX: --job-name=crusty-pastry-3895
#FLUX: --queue=bumblebee
#FLUX: -t=86400
#FLUX: --priority=16

source activate tensorflow
module load cudnn/7.0-9.0
python RNN_MODELS.py drop/2SP SPIRAL POTTS1 DSIZE=512 RUNS=0 EPOCHS=15 keep_prob=0.9
