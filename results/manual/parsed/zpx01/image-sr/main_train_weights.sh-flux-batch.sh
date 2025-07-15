#!/bin/bash
#FLUX: --job-name=loopy-latke-2444
#FLUX: -c=8
#FLUX: --urgency=16

export PYTHONUNBUFFERED='1'

pwd
hostname
date
nvidia-smi
echo "Starting SwinIR training job (classical SR)..."
source ~/.bashrc
conda activate image-sr
export PYTHONUNBUFFERED=1
OUTPUT_DIR='/checkpoints/zeeshan/second_stage/weighting_resnet/'
TRAIN_HR_DIR='/home/zeeshan/image-sr/trainsets/trainH/DIV2K_train_HR_sub/'
TRAIN_LR_DIR='/home/zeeshan/image-sr/trainsets/trainL/DIV2K_train_LR_bicubic/X4_sub/'
TRAIN_TTT_DIR='/checkpoints/zeeshan/test_time_training/ttt_div2k_trainset/outputs/swinir_classical_sr_x4_train_ttt/'
TRAIN_PRETRAIN_DIR='/checkpoints/zeeshan/test_time_training/ttt_div2k_trainset/outputs/swinir_classical_sr_x4_train_orig/'
TEST_HR_DIR='/home/zeeshan/image-sr/testsets/Set14_kair/original/'
TEST_LR_DIR='/home/zeeshan/image-sr/testsets/Set14_kair/LRbicx4/'
TEST_TTT_DIR='/checkpoints/zeeshan/test_time_training/set14_ttt/outputs/'
TEST_PRETRAIN_DIR='/checkpoints/zeeshan/test_time_training/set14_swinir/outputs/'
OPT_TYPE='SGD'
for LR in 0.001 0.0001
do
        python3 main_train_weights.py \
        --lr ${LR} \
        --train_hr_dir ${TRAIN_HR_DIR} \
        --test_hr_dir ${TEST_HR_DIR} \
        --train_pretrain_dir ${TRAIN_PRETRAIN_DIR} \
        --test_pretrain_dir ${TEST_PRETRAIN_DIR} \
        --train_ttt_dir ${TRAIN_TTT_DIR} \
        --test_ttt_dir ${TEST_TTT_DIR} \
        --output_dir ${OUTPUT_DIR}${LR} \
        --train_lr_dir ${TRAIN_LR_DIR} \
        --test_lr_dir ${TEST_LR_DIR} \
        --batch_size 32 \
        --epochs 40 \
        --img_size 72 \
        --window_size 12 \
        --opt_type ${OPT_TYPE}
done
date
