#!/bin/bash
#FLUX: --job-name=eval_custom
#FLUX: -c=16
#FLUX: -t=864000
#FLUX: --urgency=16

cd ~/segdet_mlcr2024 || exit
docker build -t segdet .
echo "Running on GPU $CUDA_VISIBLE_DEVICES"
docker run --gpus all --rm --ipc host \
  --mount type=bind,source=.,target=/app/ \
  --mount type=bind,source=$(pwd)/data/coco,target=/app/data/coco \
  --mount type=bind,source=/dev/shm,target=/dev/shm \
  segdet bash -c "mim install mmcv==2.1.0 mmdet==3.3.0 && python3 tools/metrics.py --conf config/rtmdet.py --weights weights/rtmdet.pth --gpu $CUDA_VISIBLE_DEVICES"
docker run --gpus all --rm --ipc host \
  --mount type=bind,source=.,target=/app/ \
  --mount type=bind,source=$(pwd)/data/coco,target=/app/data/coco \
  --mount type=bind,source=/dev/shm,target=/dev/shm \
  segdet bash -c "mim install mmcv==2.1.0 mmdet==3.3.0 && python3 tools/metrics.py --conf config/vitdet.py --weights weights/vitdet_preliminary.pth --gpu $CUDA_VISIBLE_DEVICES"
