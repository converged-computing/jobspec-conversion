#!/bin/bash
#FLUX: --job-name=salted-leader-6212
#FLUX: --queue=Teach-Standard
#FLUX: -t=28800
#FLUX: --urgency=16

export CUDA_HOME='/opt/cuda-9.0.176.1/'
export CUDNN_HOME='/opt/cuDNN-7.0/'
export STUDENT_ID='$(whoami)'
export LD_LIBRARY_PATH='${CUDNN_HOME}/lib64:${CUDA_HOME}/lib64:$LD_LIBRARY_PATH'
export LIBRARY_PATH='${CUDNN_HOME}/lib64:$LIBRARY_PATH'
export CPATH='${CUDNN_HOME}/include:$CPATH'
export PATH='${CUDA_HOME}/bin:${PATH}'
export PYTHON_PATH='$PATH'
export TMPDIR='/disk/scratch/${STUDENT_ID}/'
export TMP='/disk/scratch/${STUDENT_ID}/'
export DATASET_DIR='${TMP}/datasets/'

export CUDA_HOME=/opt/cuda-9.0.176.1/
export CUDNN_HOME=/opt/cuDNN-7.0/
export STUDENT_ID=$(whoami)
export LD_LIBRARY_PATH=${CUDNN_HOME}/lib64:${CUDA_HOME}/lib64:$LD_LIBRARY_PATH
export LIBRARY_PATH=${CUDNN_HOME}/lib64:$LIBRARY_PATH
export CPATH=${CUDNN_HOME}/include:$CPATH
export PATH=${CUDA_HOME}/bin:${PATH}
export PYTHON_PATH=$PATH
mkdir -p /disk/scratch/${STUDENT_ID}
export TMPDIR=/disk/scratch/${STUDENT_ID}/
export TMP=/disk/scratch/${STUDENT_ID}/
mkdir -p ${TMP}/datasets/
export DATASET_DIR=${TMP}/datasets/
source /home/${STUDENT_ID}/miniconda3/bin/activate mlp
cd ..
python train_models.py --batch_size 64 \
                        --num_epochs 50 \
                        --continue_from_epoch -2 \
                        --experiment_name "resnet50_base_224" \
                        --weight_decay_coefficient 0.0005 \
                        --learning_rate 0.001 \
                        --seed 0 \
                        --use_gpu "true" \
                        --model "resnet50" \
                        --pretrain "base" \
                        --dataloader "birds" \
                        --height 224 \
                        --width 224
