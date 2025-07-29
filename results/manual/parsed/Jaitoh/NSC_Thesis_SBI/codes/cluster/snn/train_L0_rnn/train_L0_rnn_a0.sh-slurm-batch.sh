#!/bin/bash
#SBATCH --job-name=train_L0_rnn_a0
#SBATCH --output=./cluster/uzh/train_L0_rnn/train_logs/train_L0_rnn_a0.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --gres=gpu:V100:1
#SBATCH --mem=16G
#SBATCH --time=1-00:00:00

RUN_ID=a0
TRAIN_FILE_NAME=train_L0_rnn
CLUSTER=snn
CONFIG_SIMULATOR_PATH=./src/config/test/test_simulator.yaml
CONFIG_DATASET_PATH=./src/config/test/test_dataset.yaml
CONFIG_TRAIN_PATH=./src/config/test/test_train.yaml
JOB_NAME=${TRAIN_FILE_NAME_}${RUN_ID}
OUTPUT_FILE=./cluster/${CLUSTER}/${TRAIN_FILE_NAME}/output_logs/${JOB_NAME}.out
LOG_DIR=./src/train/logs/${TRAIN_FILE_NAME}/${RUN_ID}
python3 -u ./src/train/${TRAIN_FILE_NAME}.py \
--seed 100 \
--config_simulator_path ${CONFIG_SIMULATOR_PATH} \
--config_dataset_path ${CONFIG_DATASET_PATH} \
--config_train_path ${CONFIG_TRAIN_PATH} \
--log_dir ${LOG_DIR} \
--gpu \
-y &> ${OUTPUT_FILE}
echo 'finished simulation'
