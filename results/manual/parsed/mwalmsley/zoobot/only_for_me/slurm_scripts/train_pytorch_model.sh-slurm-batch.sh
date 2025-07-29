#!/bin/bash
#FLUX: --job-name=pytorch
#FLUX: -c=24
#FLUX: --exclusive
#FLUX: -t=82800
#FLUX: --urgency=16

export WANDB_CACHE_DIR='/share/nas2/walml/WANDB_CACHE_DIR'

pwd; hostname; date
nvidia-smi
export WANDB_CACHE_DIR=/share/nas2/walml/WANDB_CACHE_DIR
ZOOBOT_DIR=/share/nas2/walml/repos/zoobot
PYTHON=/share/nas2/walml/miniconda3/envs/zoobot/bin/python
THIS_DIR=/share/nas2/walml/repos/gz-decals-classifiers
EXPERIMENT_DIR=$THIS_DIR/results/pytorch/effnet_train_only_dr5_greyscale_pytorch
$PYTHON /share/nas2/walml/repos/zoobot/zoobot/pytorch/examples/train_model.py \
    --experiment-dir $EXPERIMENT_DIR \
    --shard-img-size 300 \
    --resize-size 224 \
    --color \
    --catalog ${THIS_DIR}/data/decals/shards/all_campaigns_ortho_v2/dr5/labelled_catalog.csv \
    --epochs 200 \
    --batch-size 256 \
    --gpus 1  \
    --nodes 1 \
    --wandb
