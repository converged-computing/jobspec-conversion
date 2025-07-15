#!/bin/bash
#FLUX: --job-name=unet
#FLUX: -n=8
#FLUX: --queue=gpu
#FLUX: -t=518400
#FLUX: --priority=16

export CUDA_VISIBLE_DEVICES='0,1,2,3'
export FLAGS_sync_nccl_allreduce='1 # use nccl to do allreduce'
export FLAGS_enable_parallel_graph='1 # enable parallel graph mode'

source ~/.bashrc
conda activate paddle_x3.9
module load cuda
export CUDA_VISIBLE_DEVICES=0,1,2,3
'''
export FLAGS_sync_nccl_allreduce=1 # use nccl to do allreduce
export FLAGS_enable_parallel_graph=1 # enable parallel graph mode
'''
python -m paddle.distributed.launch --log_dir=output_unet unet.py
