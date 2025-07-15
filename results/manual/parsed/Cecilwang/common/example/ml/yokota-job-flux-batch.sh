#!/bin/bash
#FLUX: --job-name=gassy-buttface-4997
#FLUX: --urgency=16

export PYTHONPATH='$PYTHONPATH:$HOME/asdfghjkl:$PYTHONPATH:$HOME/common:$HOME/sam:$HOME/vit-pytorch'

source /etc/profile.d/modules.sh
module load cuda/11.4
module load cudnn/cuda-11.4
source $HOME/vir/py3/bin/activate
export PYTHONPATH=$PYTHONPATH:$HOME/asdfghjkl:$PYTHONPATH:$HOME/common:$HOME/sam:$HOME/vit-pytorch
python 12_sam_vs_ivon.py --opt ivon --data_path .data --dataset CIFAR10 --model=cifar10_resnet_20 --mc_samples 8 --test_mc_samples 8 --lr 5 --prior_prec 250.0 --momentum_grad 0.8 --momentum_hess 0.9 --epochs=120 --batch_size=2048 --warmup_steps=0 --dp_warmup_epochs=60 --dp 0.1
