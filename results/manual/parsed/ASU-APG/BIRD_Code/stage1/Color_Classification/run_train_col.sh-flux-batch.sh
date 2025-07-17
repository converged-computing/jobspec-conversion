#!/bin/bash
#FLUX: --job-name=loopy-truffle-6171
#FLUX: -N=2
#FLUX: -n=4
#FLUX: --queue=wildfire
#FLUX: -t=173520
#FLUX: --urgency=16

module load tensorflow/1.8-agave-gpu
cd /home/tgokhale/work/code/Color_Classification
python3 train.py --checkpoint_path ./checkpoint/lr05_b4_alpha1_beta5 --lr 0.05 --batch_size 4 --alpha 0.1 --beta 0.5
