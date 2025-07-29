#!/bin/bash
#FLUX: --job-name=train_L0_rnn_a2
#FLUX: -c=16
#FLUX: -t=86400
#FLUX: --urgency=16

module load intel
module load anaconda3
source activate sbi
RUN_ID=a2
TRAIN_FILE_NAME=train_L0_rnn
CLUSTER=uzh
CONFIG_SIMULATOR_PATH=./src/config/test/test_simulator_2.yaml
CONFIG_DATASET_PATH=./src/config/test/test_dataset.yaml
CONFIG_TRAIN_PATH=./src/config/test/test_train.yaml
JOB_NAME=$TRAIN_FILE_NAME_$RUN_ID
OUTPUT_FILE=./cluster/$CLUSTER/$TRAIN_FILE_NAME/train_logs/$JOB_NAME.out
LOG_DIR=./src/train/logs/$TRAIN_FILE_NAME/$RUN_ID
python3 -u ./src/train/$TRAIN_FILE_NAME.py \
--seed 100 \
--config_simulator_path $CONFIG_SIMULATOR_PATH \
--config_dataset_path $CONFIG_DATASET_PATH \
--config_train_path $CONFIG_TRAIN_PATH \
--log_dir $LOG_DIR \
--gpu \
-y
echo 'finished simulation'
