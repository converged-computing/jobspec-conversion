#!/bin/bash
#SBATCH --job-name=tf-jit-test
#SBATCH --output=logs/%x-%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=32
#SBATCH --gres=1
#SBATCH --constraint=gpu

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
