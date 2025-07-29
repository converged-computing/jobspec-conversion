#!/bin/bash
#FLUX: --job-name=train
#FLUX: -t=14400
#FLUX: --urgency=16

module load gcc/8.2.0 python_gpu/3.10.4 eth_proxy
pip install . src/guided-diffusion
DATA="$HOME/Latent-DIRE/data/data"
NAME="LDIRE-10k L-ResNet50"
MODEL="resnet50_latent"
python src/training.py --model $MODEL --name $NAME --data_dir $DATA --batch_size 256 --max_epochs 1000
