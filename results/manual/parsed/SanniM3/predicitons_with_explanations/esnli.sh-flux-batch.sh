#!/bin/bash
#FLUX: --job-name=bricky-kitty-1715
#FLUX: --queue=PGR-Standard
#FLUX: -t=72000
#FLUX: --urgency=16

export CUDA_HOME='/opt/cuda-9.0.176.1/'
export CUDNN_HOME='/opt/cuDNN-7.0/'
export STUDENT_ID='$(whoami)'
export LD_LIBRARY_PATH='${CUDNN_HOME}/lib64:${CUDA_HOME}/lib64:$LD_LIBRARY_PATH'
export LIBRARY_PATH='${CUDNN_HOME}/lib64:$LIBRARY_PATH'
export CPATH='${CUDNN_HOME}/include:$CPATH'
export PATH='${CUDA_HOME}/bin:${PATH}'
export PYTHON_PATH='$PATH'

export CUDA_HOME=/opt/cuda-9.0.176.1/
export CUDNN_HOME=/opt/cuDNN-7.0/
export STUDENT_ID=$(whoami)
export LD_LIBRARY_PATH=${CUDNN_HOME}/lib64:${CUDA_HOME}/lib64:$LD_LIBRARY_PATH
export LIBRARY_PATH=${CUDNN_HOME}/lib64:$LIBRARY_PATH
export CPATH=${CUDNN_HOME}/include:$CPATH
export PATH=${CUDA_HOME}/bin:${PATH}
export PYTHON_PATH=$PATH
source /home/${STUDENT_ID}/miniconda3/bin/activate feb
python scripts/exp.py --exp_root checkpoints --not_dryrun --model_vals t5-base,t5-large,t5-3b --dataset_vals esnli --n_gpus 4
python scripts/exp.py --exp_root checkpoints --collect_results
