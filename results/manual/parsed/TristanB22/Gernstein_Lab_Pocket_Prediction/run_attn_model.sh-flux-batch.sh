#!/bin/bash
#FLUX: --job-name=attn_pocket_prediction
#FLUX: -c=6
#FLUX: --queue=gpu
#FLUX: -t=72000
#FLUX: --priority=16

python -m pip install --upgrade pip
module purge
module load PyTorch
module load CUDA/12.1.1
pip install tqdm
pip install matplotlib
pip install torchviz
python3 train_model.py
