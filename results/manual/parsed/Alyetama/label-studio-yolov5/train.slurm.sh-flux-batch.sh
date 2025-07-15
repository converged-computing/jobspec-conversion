#!/bin/bash
#FLUX: --job-name='train'
#FLUX: --queue=gpu
#FLUX: -t=86400
#FLUX: --priority=16

nvidia-smi
module unload python
module load anaconda
module load cuda/10.2
conda activate yolov5
PROJECT_ID=1  # Label Studio project ID
BATCH_SIZE=32
EPOCHS=100
PRETRAINED_WEIGHTS='https://github.com/microsoft/CameraTraps/releases/download/v5.0/md_v5a.0.0.pt'
python prepare_dataset.py -p "$PROJECT_ID" || exit 1
python yolov5/train.py \
  --data 'dataset/dataset_config.yml' \
  --batch "$BATCH_SIZE" \
  --epochs "$EPOCHS" \
  --weights "$PRETRAINED_WEIGHTS"
