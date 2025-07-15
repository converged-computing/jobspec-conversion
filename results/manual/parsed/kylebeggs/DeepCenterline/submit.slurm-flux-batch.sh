#!/bin/bash
#FLUX: --job-name=conspicuous-frito-6103
#FLUX: -t=43200
#FLUX: --priority=16

module load anaconda/anaconda3
module list
source activate torch-medical
nvidia-smi
nvidia-smi topo -m
cd src
python train.py --name pooling --model pooling --epochs 20 --lr 0.01
