#!/bin/bash
#FLUX: --job-name=inm705_SR
#FLUX: -c=4
#FLUX: --queue=prigpu
#FLUX: -t=172800
#FLUX: --urgency=16

export WANDB_API_KEY='37d31add06ffd6210d871e1462ad8777b14e5999'
export https_proxy='http://hpc-proxy00.city.ac.uk:3128'

source /opt/flight/etc/setup.sh
flight env activate gridware
module load libs/nvidia-cuda/11.2.0/bin
module load gnu
export WANDB_API_KEY=37d31add06ffd6210d871e1462ad8777b14e5999
echo $WANDB_API_KEY
python --version
nvidia-smi
wandb login $WANDB_API_KEY --relogin
export https_proxy=http://hpc-proxy00.city.ac.uk:3128
python3 train.py --config configs/SRResNet.yaml
