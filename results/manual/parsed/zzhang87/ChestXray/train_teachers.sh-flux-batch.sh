#!/bin/bash
#FLUX: --job-name=resnet_50_small_train
#FLUX: -n=8
#FLUX: --queue=terramepp
#FLUX: --urgency=16

MODEL_NAME=mobilenet
TRAIN_DIR=/home/zzhang52/Insight/runs/3_teachers_100th
rm -rf $TRAIN_DIR
mkdir $TRAIN_DIR
DATA_DIR=/home/zzhang52/Insight/CXR/3_part_100th
IMAGE_DIR=/home/zzhang52/Insight/CXR/images/all
PARTITION_NUM=3
NUM_EPOCH=3
BATCH_SIZE=32
OPTIMIZER=adam
LR=0.01
for teacher in `seq 1 $PARTITION_NUM`
do
python train_one_teacher.py \
  --data_dir=${DATA_DIR} \
  --image_dir=${IMAGE_DIR} \
  --train_dir=${TRAIN_DIR}/teacher_${teacher} \
  --partition_id=${teacher} \
  --partition_num=${PARTITION_NUM} \
  --batch_size=${BATCH_SIZE} \
  --num_epoch=${NUM_EPOCH} \
  --model_name=${MODEL_NAME} \
  --optimizer=${OPTIMIZER} \
  --initial_lr=${LR}
done
