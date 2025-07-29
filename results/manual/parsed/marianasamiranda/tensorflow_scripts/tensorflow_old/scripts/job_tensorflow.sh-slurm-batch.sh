#!/bin/bash
#FLUX: --job-name=tf-tenosorflow
#FLUX: --queue=rtx
#FLUX: -t=10800
#FLUX: --urgency=16

WORKSPACE=$(dirname $(dirname $(realpath $0)))
DATA_DIR="/scratch1/08486/mmiranda/mysharedirectory"
cd "${WORKSPACE}/scripts"
EPOCHS=1
BATCH_SIZE=256
DATE="$(date +%Y_%m_%d-%H_%M)"
TARGET_DIR="/tmp"
DATASET="/home/gsd/tensorflow/100g_tfrecords"
for i in {1..1}; do
  RUN_DIR="${TARGET_DIR}/resnet-100g-bs${BATCH_SIZE}-ep${EPOCHS}-${DATE}"
  #remora ./train.sh -o -m resnet -b $BATCH_SIZE -e $EPOCHS -g 4 -i autotune -l -v -d "$DATASET" -r $RUN_DIR
  ./train.sh -o -m resnet -b $BATCH_SIZE -e $EPOCHS -g 1 -i autotune -l -v -d "$DATASET" -r $RUN_DIR
  sleep 10
  mv "remora_${SLURM_JOB_ID}" $RUN_DIR
done
DATASET="${DATA_DIR}/imagenet_processed/200g_2048_tfrecords"
