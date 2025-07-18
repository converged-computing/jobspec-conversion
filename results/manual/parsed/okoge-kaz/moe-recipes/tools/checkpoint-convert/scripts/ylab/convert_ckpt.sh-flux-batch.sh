#!/bin/bash
#FLUX: --job-name=convert
#FLUX: -t=86400
#FLUX: --urgency=16

. /etc/profile.d/modules.sh
module load cuda/11.8
module load cudnn/cuda-11.x/8.9.0
module load nccl/cuda-11.7/2.14.3
module load openmpi/4.0.5
set -e
source .env/bin/activate
start=1000
end=2000
increment=1000
for ((i = start; i <= end; i += increment)); do
  ITERATION=$i
  FORMATTED_ITERATION=$(printf "iter_%07d" $ITERATION)
  CHECK_POINT_PATH=/home/kazuki/checkpoints/Mixtral-8x7b/${FORMATTED_ITERATION}/model.pt
  OUTPUT_PATH=/home/kazuki/converted_checkpoints/Mixtral-8x7b/${FORMATTED_ITERATION}
  echo "convert ${CHECK_POINT_PATH} to ${OUTPUT_PATH}"
  mkdir -p $OUTPUT_PATH
  BASE_MODEL_CHECKPOINT=/home/kazuki/hf_checkpoints/Mixtral-8x7B-v0.1
  python tools/checkpoint-convert/convert_ckpt.py \
    --model $BASE_MODEL_CHECKPOINT \
    --ckpt $CHECK_POINT_PATH \
    --out $OUTPUT_PATH \
    --sequence-length 4096
done
