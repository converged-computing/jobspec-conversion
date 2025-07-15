#!/bin/bash
#FLUX: --job-name=$NAME
#FLUX: -c=16
#FLUX: -t=864000
#FLUX: --priority=16

cd ~/segdet_mlcr2024 || exit
docker build -t segdet .
echo "Running on GPU $CUDA_VISIBLE_DEVICES"
docker run --gpus all --rm --ipc host \
  --mount type=bind,source=.,target=/app/ \
  --mount type=bind,source=$(pwd)/data/coco,target=/app/data/coco \
  --mount type=bind,source=/dev/shm,target=/dev/shm \
  segdet bash -c "mim install mmcv==2.1.0 mmdet==3.3.0 && python3 tools/train.py $CONFIG --gpu $CUDA_VISIBLE_DEVICES"
