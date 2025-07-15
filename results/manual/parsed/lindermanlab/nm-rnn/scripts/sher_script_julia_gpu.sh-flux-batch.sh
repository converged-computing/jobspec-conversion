#!/bin/bash
#FLUX: --job-name=nmrnn
#FLUX: --gpus-per-task=1
#FLUX: --queue=normal,hns,owners,swl1
#FLUX: -t=14400
#FLUX: --priority=16

ml python/3.9
source /home/groups/swl1/nm-rnn/.venv/bin/activate
wandb agent nm-rnn/nm-rnn-mwg/nmpc45l4
