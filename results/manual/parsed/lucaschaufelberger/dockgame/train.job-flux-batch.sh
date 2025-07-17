#!/bin/bash
#FLUX: --job-name=dockgame
#FLUX: -c=8
#FLUX: --queue=gpu
#FLUX: -t=86280
#FLUX: --urgency=16

export WANDB_API_KEY='87ae4293cc8f38d09bcc01d3a52d34b68630a156'
export PYTHONPATH=':/cluster/work/jorner/schaluca/Software/models/diffusion/dockgame'

script=
shift
module load eth_proxy
wandb login
export WANDB_API_KEY=87ae4293cc8f38d09bcc01d3a52d34b68630a156
module load gcc/8.2.0 python_gpu/3.11.2
export PYTHONPATH=:/cluster/work/jorner/schaluca/Software/models/diffusion/dockgame
mamba activate dockgame
python scripts/train/score.py --config /cluster/work/jorner/schaluca/Software/models/diffusion/dockgame/paper/score_model/config_train.yml 
