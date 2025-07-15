#!/bin/bash
#FLUX: --job-name=confused-bits-3894
#FLUX: --queue=gpu4
#FLUX: -t=3000
#FLUX: --urgency=16

export HF_HOME='/scratch/fhoels2s/huggingface'
export MASTER_ADDR='localhost'
export MASTER_PORT='$((15000 + $RANDOM % 5000))'
export TORCH_DISTRIBUTED_DEBUG='DETAIL'
export NCCL_DEBUG_SUBSYS='ALL'
export NCCL_DEBUG='INFO'
export NCCL_IB_DISABLE='1'
export CUDA_LAUNCH_BLOCKING='1'
export TOKENIZERS_PARALLELISM='false'

cd ~/secora
module load gcc/8.2.0
module load cmake
module load cuda/11.2
module load python3
export HF_HOME=/scratch/fhoels2s/huggingface
export MASTER_ADDR="localhost"
export MASTER_PORT=$((15000 + $RANDOM % 5000))
export TORCH_DISTRIBUTED_DEBUG=DETAIL
export NCCL_DEBUG_SUBSYS=ALL
export NCCL_DEBUG=INFO
export NCCL_IB_DISABLE=1
export CUDA_LAUNCH_BLOCKING=1
export TOKENIZERS_PARALLELISM=false
pipenv run python secora/train.py --debug configs/cluster.yml --name debug_cluster_gpu4
