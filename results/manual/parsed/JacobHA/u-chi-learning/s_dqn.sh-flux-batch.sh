#!/bin/bash
#FLUX: --job-name=logu-%A_%a
#FLUX: -c=4
#FLUX: --queue=gpu
#FLUX: -t=172800
#FLUX: --priority=16

export WANDB_MODE='offline'

module load anaconda/3.9
source /home/$USER/.bashrc
conda activate u-chi-learning
export WANDB_MODE=offline
wandb offline
python experiments/dqn_baseline.py --n_runs=1 --proj=u-chi-learning
