#!/bin/bash
#FLUX: --job-name=fuzzy-cattywampus-3949
#FLUX: -c=20
#FLUX: --queue=xeon-g6-volta
#FLUX: -t=900
#FLUX: --urgency=16

export LD_LIBRARY_PATH='/home/gridsan/asimeono/.conda/envs/furniture-env/lib/python3.8/site-packages/nvidia/cudnn/lib:$LD_LIBRARY_PATH'
export AWS_COMMAND='/home/gridsan/asimeono/aws-cli/v2/current/bin/aws'
export DATA_DIR_PROCESSED='/home/gridsan/asimeono/data/furniture-data/'
export WANDB_ENTITY='robot-rearrangement'

source /etc/profile
module load anaconda/2022b
module load cuda/11.3
source activate furniture-env
export LD_LIBRARY_PATH=/home/gridsan/asimeono/.conda/envs/furniture-env/lib:$LD_LIBRARY_PATH
export LD_LIBRARY_PATH=/home/gridsan/asimeono/.conda/envs/furniture-env/lib/python3.8/site-packages/nvidia/cudnn/lib:$LD_LIBRARY_PATH
export AWS_COMMAND='/home/gridsan/asimeono/aws-cli/v2/current/bin/aws'
export DATA_DIR_PROCESSED="/home/gridsan/asimeono/data/furniture-data/"
export WANDB_ENTITY="robot-rearrangement"
alias aws='/home/gridsan/asimeono/aws-cli/v2/current/bin/aws'
cd ~/repos/research/furniture-diffusion
python -m src.train.bc_no_rollout +experiment=image_mlp_10m wandb.mode=offline furniture=round_table data.dataloader_workers=20 pred_horizon=1 action_horizon=1
