#!/bin/bash
#FLUX: --job-name=TTA
#FLUX: --queue=gpu
#FLUX: -t=259200
#FLUX: --urgency=16

export NCCL_DEBUG='INFO'
export CUDA_LAUNCH_BLOCKING='1'

export NCCL_DEBUG=INFO
export CUDA_LAUNCH_BLOCKING=1
source activate llm-tta
experiment_make=$1
seed=$2
make $experiment_make SEED=$seed
