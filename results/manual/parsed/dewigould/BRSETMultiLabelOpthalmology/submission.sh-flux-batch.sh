#!/bin/bash
#FLUX: --job-name=tensor
#FLUX: --queue=short
#FLUX: -t=41400
#FLUX: --priority=16

export XLA_FLAGS='--xla_gpu_cuda_data_dir=/apps/system/easybuild/software/CUDA/11.8.0/'

module load Anaconda3
module load CUDA/11.8.0
export XLA_FLAGS=--xla_gpu_cuda_data_dir=/apps/system/easybuild/software/CUDA/11.8.0/
source activate /data/math-dewi-nn/ball5622/dewi-tf2-gpu
python run.py
conda deactivate
