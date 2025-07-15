#!/bin/bash
#FLUX: --job-name=label_distillation
#FLUX: --queue=PGR-Standard
#FLUX: -t=162671
#FLUX: --priority=16

export CUDA_HOME='/opt/cuda-10.0.130/'
export CUDNN_HOME='/opt/cuDNN-7.6.0.64_10.0/'
export STUDENT_ID='$(whoami)'
export LD_LIBRARY_PATH='${CUDNN_HOME}/lib64:${CUDA_HOME}/lib64:$LD_LIBRARY_PATH'
export LIBRARY_PATH='${CUDNN_HOME}/lib64:$LIBRARY_PATH'
export CPATH='${CUDNN_HOME}/include:$CPATH'
export PATH='${CUDA_HOME}/bin:${PATH}'
export PYTHON_PATH='$PATH'

export CUDA_HOME=/opt/cuda-10.0.130/
export CUDNN_HOME=/opt/cuDNN-7.6.0.64_10.0/
export STUDENT_ID=$(whoami)
export LD_LIBRARY_PATH=${CUDNN_HOME}/lib64:${CUDA_HOME}/lib64:$LD_LIBRARY_PATH
export LIBRARY_PATH=${CUDNN_HOME}/lib64:$LIBRARY_PATH
export CPATH=${CUDNN_HOME}/include:$CPATH
export PATH=${CUDA_HOME}/bin:${PATH}
export PYTHON_PATH=$PATH
source /home/${STUDENT_ID}/miniconda3/bin/activate meta_learning_pytorch_env_2
python main.py --mode distill_basic --dataset Cifar10 --arch ResNet --distill_lr 0.001
