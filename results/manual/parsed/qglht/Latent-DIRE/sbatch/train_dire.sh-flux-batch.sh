#!/bin/bash
#FLUX: --job-name=train
#FLUX: -t=14400
#FLUX: --priority=16

module load gcc/8.2.0 python_gpu/3.10.4 eth_proxy
pip install . src/guided-diffusion
NAME="DIRE 10k ResNet50"
MODEL="resnet50_pixel" # resnet50_pixel or resnet50_latent
DATA_TYPE="images" # images or latent
DATA="$HOME/Latent-DIRE/data/dire"
python src/training.py \
--name "$NAME" \
--model $MODEL \
--data_type $DATA_TYPE \
--data_dir $DATA \
--freeze_backbone 1\
--batch_size 256 \
--max_epochs 1000 \
--num_workers 0 # if used, specify #SBATCH --cpus-per-task
