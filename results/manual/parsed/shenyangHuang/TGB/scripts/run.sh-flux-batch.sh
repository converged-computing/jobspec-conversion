#!/bin/bash
#FLUX: --job-name=delicious-train-0255
#FLUX: -c=4
#FLUX: --queue=long
#FLUX: -t=172800
#FLUX: --urgency=16

export HOME='/home/mila/h/huangshe'

export HOME="/home/mila/h/huangshe"
module load python/3.9
source $HOME/tgbenv/bin/activate
pwd
CUDA_VISIBLE_DEVICES=0 python examples/nodeproppred/un_trade/dyrep.py --seed 5
