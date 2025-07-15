#!/bin/bash
#FLUX: --job-name=stanky-omelette-5607
#FLUX: --queue=gpu4
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
pipenv run python secora/profiling.py configs/cluster.yml --modes train --name profile_gpu4_train
pipenv run python secora/profiling.py configs/cluster.yml --modes embedding --name profile_gpu4_embedding
pipenv run python secora/profiling.py configs/cluster.yml --modes validation --name profile_gpu4_validation
