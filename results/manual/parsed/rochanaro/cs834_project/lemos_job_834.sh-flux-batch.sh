#!/bin/bash
#FLUX: --job-name=gloopy-lettuce-3752
#FLUX: --urgency=16

export CUDA_HOME='/cm/shared/applications/cuda-toolkit/11.7.1/'
export XLA_FLAGS='--xla_gpu_cuda_data_dir=$CUDA_HOME'

enable_lmod
module load container_env tensorflow-gpu/2.12.0
export CUDA_HOME=/cm/shared/applications/cuda-toolkit/11.7.1/
export XLA_FLAGS=--xla_gpu_cuda_data_dir=$CUDA_HOME
crun.tensorflow-gpu -p ~/envs/cs834_project python lemos_kerasnlp_for_slurm_job_training.py -itr $iteration -ep $epochs
