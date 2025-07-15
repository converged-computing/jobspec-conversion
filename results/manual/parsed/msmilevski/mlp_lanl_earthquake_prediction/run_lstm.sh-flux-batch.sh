#!/bin/bash
#FLUX: --job-name=crunchy-chair-5719
#FLUX: --queue=LongJobs
#FLUX: -t=108000
#FLUX: --priority=16

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
python scripts/experiments/lstm_experiment.py --data_path /home/${STUDENT_ID}/lanl_earthquake/data \
											 --experiment_name "lstm_full_raw" \
											 --segment_size 150000 --element_size 1000 \
											 --use_gpu "true" --gpu_id "0,1" \
											 --num_epochs 60 --dropout 0.3 \
											 --learning_rate 0.0002
