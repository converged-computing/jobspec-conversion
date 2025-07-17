#!/bin/bash
#FLUX: --job-name=yolov7
#FLUX: -c=16
#FLUX: -t=864000
#FLUX: --urgency=16

cd ~/segdet_mlcr2024 || exit
docker build -t segdet .
docker run --gpus all -e CUDA_VISIBLE_DEVICES=$CUDA_VISIBLE_DEVICES --rm --ipc host \
  --mount type=bind,source=.,target=/app/ \
  --mount type=bind,source=$(pwd)/data/coco,target=/app/data/coco \
  --mount type=bind,source=/dev/shm,target=/dev/shm \
  segdet bash -c "mim install mmcv==2.1.0 mmdet==3.3.0 && python3 segdet/models/yolov7/yolo_train.py --workers 8 --device $CUDA_VISIBLE_DEVICES --batch-size 64 --data config/coco.yaml --img 640 640 --cfg config/config_yolov7.yaml --weights yolov7_training.pt --name yolov7-base --hyp config/hyp_scratch_yolov7.yaml"
