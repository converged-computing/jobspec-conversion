#!/bin/bash
#FLUX: --job-name=fat-nunchucks-7169
#FLUX: --priority=16

source ~/.bashrc
conda activate /scratch/maj596/conda-envs/IPNV2_pytorch
python IPN\ V2_train.py
