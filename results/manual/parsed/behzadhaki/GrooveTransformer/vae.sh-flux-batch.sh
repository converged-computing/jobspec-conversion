#!/bin/bash
#FLUX: --job-name=delicious-nunchucks-4641
#FLUX: -c=10
#FLUX: -t=86400
#FLUX: --priority=16

export PATH='$HOME/miniconda_envs/anaconda3/envs/GrooveTransformer:$PATH'
export WANDB_API_KEY='API_KEY'

export PATH="$HOME/miniconda_envs/anaconda3/bin:$PATH"
export PATH="$HOME/miniconda_envs/anaconda3/envs/GrooveTransformer:$PATH"
source activate GrooveTransformer
cd GrooveTransformer
export WANDB_API_KEY="API_KEY"
python -m wandb login
wandb agent mmil_vae_g2d/SmallSweeps_MGT_VAE/b339vcez
