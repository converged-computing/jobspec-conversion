#!/bin/bash
#FLUX: --job-name=loca_few_shot
#FLUX: -c=12
#FLUX: --queue=gpu
#FLUX: -t=86400
#FLUX: --urgency=16

export MASTER_ADDR='$master_addr'
export MASTER_PORT='50188'
export NCCL_P2P_DISABLE='1'
export NCCL_IB_DISABLE='1'
export NCCL_BLOCKING_WAIT='1'

master_addr=$(scontrol show hostnames "$SLURM_JOB_NODELIST" | head -n 1)
export MASTER_ADDR=$master_addr
export MASTER_PORT=50188
export NCCL_P2P_DISABLE=1
export NCCL_IB_DISABLE=1
export NCCL_BLOCKING_WAIT=1
module load Anaconda3
source activate pytorch
conda activate base
conda activate pytorch
srun python train.py \
--model_name loca_few_shot \
--data_path /d/hpc/projects/FRI/nd1776/data/fsc147 \
--model_path /d/hpc/projects/FRI/nd1776/pretrained \
--backbone resnet50 \
--swav_backbone \
--reduction 8 \
--image_size 512 \
--num_enc_layers 3 \
--num_ope_iterative_steps 3 \
--emb_dim 256 \
--num_heads 8 \
--kernel_dim 3 \
--num_objects 3 \
--epochs 200 \
--lr 1e-4 \
--backbone_lr 0 \
--lr_drop 300 \
--weight_decay 1e-4 \
--batch_size 4 \
--dropout 0.1 \
--num_workers 8 \
--max_grad_norm 0.1 \
--aux_weight 0.3 \
--tiling_p 0.5 \
--pre_norm
