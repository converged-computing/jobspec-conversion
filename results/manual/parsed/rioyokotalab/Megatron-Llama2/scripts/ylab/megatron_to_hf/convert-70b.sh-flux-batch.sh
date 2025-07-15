#!/bin/bash
#FLUX: --job-name=convert
#FLUX: -t=43200
#FLUX: --priority=16

. /etc/profile.d/modules.sh
module load cuda/11.8
module load cudnn/cuda-11.x/8.9.0
module load nccl/cuda-11.7/2.14.3
module load openmpi/4.0.5
set -e
cd /home/kazuki/llama/Megatron-LM
source .env/bin/activate
BASE_TENSOR_PARALLEL_SIZE=1   # fixed
BASE_PIPELINE_PARALLEL_SIZE=1 # fixed
ITERATION=5000
FORMATTED_ITERATION=$(printf "%07d" $ITERATION)
SAVE_DIR=/home/kazuki/hf_checkpoints/Llama-2-70b/iter_${FORMATTED_ITERATION}
mkdir -p ${SAVE_DIR}
echo $ITERATION >/home/kazuki/checkpoints/llama-2-70b-base/tp${BASE_TENSOR_PARALLEL_SIZE}-pp${BASE_PIPELINE_PARALLEL_SIZE}/latest_checkpointed_iteration.txt
python scripts/abci/megatron_to_hf/llama_checkpoint_conversion.py \
  --convert_checkpoint_from_megatron_to_transformers \
  --load_path /home/kazuki/checkpoints/llama-2-70b-base/tp${BASE_TENSOR_PARALLEL_SIZE}-pp${BASE_PIPELINE_PARALLEL_SIZE} \
  --save_path $SAVE_DIR \
  --target_params_dtype "bf16" \
  --print-checkpoint-structure \
  --megatron-path /home/kazuki/llama/Megatron-LM
