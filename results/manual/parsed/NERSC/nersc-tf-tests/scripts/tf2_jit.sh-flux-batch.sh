#!/bin/bash
#FLUX: --job-name=gassy-punk-6388
#FLUX: -c=32
#FLUX: --priority=16

export NCCL_DEBUG='${NCCL_DEBUG:-WARN}'
export TF_CPP_MIN_LOG_LEVEL='${TF_CPP_MIN_LOG_LEVEL:-0} #3'
export TF_CPP_MIN_VLOG_LEVEL='${TF_CPP_MIN_VLOG_LEVEL:-0} #1'
export XLA_FLAGS='--xla_gpu_cuda_data_dir=$CUDA_HOME'

module list
set -x
which python
nvidia-smi
export NCCL_DEBUG=${NCCL_DEBUG:-WARN}
export TF_CPP_MIN_LOG_LEVEL=${TF_CPP_MIN_LOG_LEVEL:-0} #3
export TF_CPP_MIN_VLOG_LEVEL=${TF_CPP_MIN_VLOG_LEVEL:-0} #1
export XLA_FLAGS="--xla_gpu_cuda_data_dir=$CUDA_HOME"
srun python tests/tf_jit.py
