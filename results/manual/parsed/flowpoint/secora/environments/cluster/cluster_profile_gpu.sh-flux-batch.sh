#!/bin/bash
#FLUX: --job-name=hanky-house-2655
#FLUX: --queue=gpu
#FLUX: -t=1200
#FLUX: --urgency=16

export HF_HOME='/scratch/fhoels2s/huggingface'
export MASTER_ADDR='localhost'
export MASTER_PORT='$((15000 + $RANDOM % 5000))'
export TOKENIZERS_PARALLELISM='false'

cd ~/secora
module load gcc/8.2.0
module load cmake
module load cuda/11.2
module load python3
export HF_HOME=/scratch/fhoels2s/huggingface
export MASTER_ADDR="localhost"
export MASTER_PORT=$((15000 + $RANDOM % 5000))
unset TORCH_DISTRIBUTED_DEBUG=DETAIL
unset NCCL_DEBUG_SUBSYS
unset NCCL_DEBUG
unset NCCL_IB_DISABLE=1
export TOKENIZERS_PARALLELISM=false
pipenv run python secora/profiling.py configs/cluster.yml --modes train --name profile_cluster_train --batch_size 64
pipenv run python secora/profiling.py configs/cluster.yml --modes embedding --name profile_cluster_embedding --batch_size 64
pipenv run python secora/profiling.py configs/cluster.yml --modes validation --name profile_cluster_validation --batch_size 64
