#!/bin/bash
#FLUX: --job-name=megatron-hf-convert
#FLUX: -t=21600
#FLUX: --urgency=16

. /etc/profile.d/modules.sh
module load cuda/11.8
module load cudnn/cuda-11.x/8.9.0
module load nccl/cuda-11.7/2.14.3
module load openmpi/4.0.5
set -e
cd /home/kazuki/llama/Megatron-LM
source .env/bin/activate
TARGET_TENSOR_PARALLEL_SIZE=1   # fixed
TARGET_PIPELINE_PARALLEL_SIZE=1 # fixed
BASE_TENSOR_PARALLEL_SIZE=8
BASE_PIPELINE_PARALLEL_SIZE=8
BASE_CHECKPOINT_DIR=/home/kazuki/checkpoints/llama-2-70b-base/tp${BASE_TENSOR_PARALLEL_SIZE}-pp${BASE_PIPELINE_PARALLEL_SIZE}
TARGET_CHECKPOINT_DIR=/home/kazuki/checkpoints/llama-2-70b-base/tp${TARGET_TENSOR_PARALLEL_SIZE}-pp${TARGET_PIPELINE_PARALLEL_SIZE}
mkdir -p ${TARGET_CHECKPOINT_DIR}
TOKENIZER_MODEL=/home/kazuki/hf_models/Llama-2-7b-hf/tokenizer.model
ITERATION=5000
echo $ITERATION >${BASE_CHECKPOINT_DIR}/latest_checkpointed_iteration.txt
python tools/checkpoint/util.py \
  --model-type GPT \
  --loader megatron \
  --saver megatron \
  --megatron-path /home/kazuki/llama/Megatron-LM \
  --target-tensor-parallel-size ${TARGET_TENSOR_PARALLEL_SIZE} \
  --target-pipeline-parallel-size ${TARGET_PIPELINE_PARALLEL_SIZE} \
  --load-dir ${BASE_CHECKPOINT_DIR} \
  --save-dir ${TARGET_CHECKPOINT_DIR}
