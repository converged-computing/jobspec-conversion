#!/bin/bash
#FLUX: --job-name=svhn-vit-distributed
#FLUX: --queue=gpu_v100s
#FLUX: -t=43200
#FLUX: --urgency=16

export CUDA_VISIBLE_DEVICES='0,1,2,3,4,5,6,7'
export MASTER_ADDR='localhost'
export MASTER_PORT='1234'
export WORLD_SIZE='8'
export NCLL_BLOCKING_WAIT='1'
export NCCL_TIMEOUT='200'

export CUDA_VISIBLE_DEVICES=0,1,2,3,4,5,6,7
export MASTER_ADDR=localhost
export MASTER_PORT=1234
export WORLD_SIZE=8
export NCLL_BLOCKING_WAIT=1
export NCCL_TIMEOUT=200
/home/zihanwu7/miniconda3/envs/dam-vp/bin/python -m torch.distributed.launch \
    --nproc_per_node=8 \
    --nnodes=1 \
    --node_rank=0 \
    --master_addr=$MASTER_ADDR \
    --master_port=$MASTER_PORT \
    task_adapting/main.py \
    --output_dir result/origin_cifar100_22k_batchsize256\
    --batch_size 256 \
    --base_dir ~/dataset \
    --pretrained_model vit-b-22k \
    --adapt_method prompt_w_head \
    --epochs 50 \
    --lr 0.5 \
    --weight_decay 1e-4 \
    --test_dataset cifar100 \
    --num_gpus 8 \
    --num_workers 1 \
    --distance_threshold 20 \
    --distributed
