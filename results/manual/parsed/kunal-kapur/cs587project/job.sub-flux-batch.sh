#!/bin/bash
#FLUX: --job-name=hanky-cinnamonbun-7584
#FLUX: -N=2
#FLUX: -t=14400
#FLUX: --urgency=16

module load anaconda/2020.11-py38
source activate cs587
python avazu_train.py -cross_layers 1 -stacked True
python avazu_train.py -cross_layers 2 -stacked True
python avazu_train.py -cross_layers 1 -reg 0.1
python avazu_train.py -cross_layers 1 -reg 0.01
python avazu_train.py -cross_layers 1 -reg 0.001
