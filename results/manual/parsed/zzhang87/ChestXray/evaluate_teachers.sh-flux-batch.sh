#!/bin/bash
#FLUX: --job-name=resnet_50_small_train
#FLUX: -n=8
#FLUX: --queue=terramepp
#FLUX: --urgency=16

MODEL_DIR=/home/paperspace/Insight
DATA_DIR=/home/paperspace/Insight/CXR/5_part_all
IMAGE_DIR=/home/paperspace/Insight/CXR/images/
PARTITION_NUM=5
BATCH_SIZE=128
for teacher in `seq 1 $PARTITION_NUM`
do
python evaluate_model.py \
  --data_dir=${DATA_DIR} \
  --image_dir=${IMAGE_DIR} \
  --model_dir=${MODEL_DIR}/teacher_${teacher} \
  --partition_id=${teacher} \
  --partition_num=${PARTITION_NUM} \
  --batch_size=${BATCH_SIZE} \
  --split_name='val'
done
for teacher in `seq 1 $PARTITION_NUM`
do
python evaluate_model.py \
  --data_dir=${DATA_DIR} \
  --image_dir=${IMAGE_DIR} \
  --model_dir=${MODEL_DIR}/teacher_${teacher} \
  --batch_size=${BATCH_SIZE} \
  --split_name='test'
done
