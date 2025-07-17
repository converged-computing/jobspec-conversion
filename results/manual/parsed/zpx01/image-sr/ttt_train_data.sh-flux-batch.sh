#!/bin/bash
#FLUX: --job-name=pusheena-cat-6417
#FLUX: -c=8
#FLUX: -t=259920
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
MODEL_PATH='/home/zeeshan/image-sr/superresolution/swinir_sr_classical_patch48_x4/models/classicalSR_SwinIR_x4.pth'
OPTIMIZER_PATH='/'
TESTSET_DIR='/home/zeeshan/image-sr/testsets/Set14_kair/LRbicx4'
BATCH_SIZE=4
ZERO_LOSS=TRUE
SAVE_FREQ=10000
NO_OPT=TRUE
OUTPUT_DIR='/checkpoints/zeeshan/test_time_training/set14_ttt/sgd_models'
python3 main_test_time.py \
        --model_path ${MODEL_PATH} \
        --opt_path ${OPTIMIZER_PATH} \
        --scale 4 \
        --num_images 15 \
        --epochs 5 \
        --test_dir ${TESTSET_DIR} \
        --output_dir ${OUTPUT_DIR} \
        --batch_size ${BATCH_SIZE} \
        --zero_loss ${ZERO_LOSS} \
        --save_freq ${SAVE_FREQ} \
        --no_opt ${NO_OPT} \
        --device 'cuda:0' 
        # &
date
