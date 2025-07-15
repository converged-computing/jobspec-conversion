#!/bin/bash
#FLUX: --job-name=Diffusion
#FLUX: -t=72000
#FLUX: --priority=16

conda activate pytorch
nvidia-smi
python -m torch.distributed.launch --nproc_per_node=8 --master_port=12233 --use_env run_train.py \
--diff_steps 1000 \
--lr 0.0001 \
--learning_steps 232184 \
--save_interval 64 \
--seed 102 \
--noise_schedule sqrt \
--hidden_dim 768 \
--bsz 512 \
--dataset artelingo \
--data_dir '../../wiki_art_paintings/english/train/artemis_preprocessed.csv' \
--vocab bert \
--seq_len 64 \
--schedule_sampler lossaware \
--notes qqp
