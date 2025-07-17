#!/bin/bash
#FLUX: --job-name=nerdy-truffle-9382
#FLUX: -t=43200
#FLUX: --urgency=16

module load anaconda/anaconda3
module list
source activate torch-medical
nvidia-smi
nvidia-smi topo -m
cd src
python train.py --name pooling --model pooling --epochs 20 --lr 0.01
