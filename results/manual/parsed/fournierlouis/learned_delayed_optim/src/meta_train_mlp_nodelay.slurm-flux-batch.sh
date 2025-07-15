#!/bin/bash
#FLUX: --job-name=train_adafac
#FLUX: -c=8
#FLUX: -t=43200
#FLUX: --urgency=16

module purge
cd /gpfswork/rech/bao/unl88dr/learned_delayed_optim/
module load cpuarch/amd
module load cudnn/10.1-v7.5.1.10
module load python/3.11.5
source venv3/bin/activate
wandb offline
set -x
python3.11 src/main.py \
    --config config/meta_train/meta_train_mlp_image-mlp-fmst_schedule_3e-3_10000_d3.py \
    --num_local_steps 4 \
    --num_grads 8 \
    --local_learning_rate 0.5 \
    --tfds_data_dir $STORE/tf_datasets\
    --wandb_dir $STORE/jax_wandb
