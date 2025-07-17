#!/bin/bash
#FLUX: --job-name=chunky-lemur-4937
#FLUX: -c=10
#FLUX: -t=1800
#FLUX: --urgency=16

export NCCL_DEBUG='INFO'
export NCCL_IB_CUDA_SUPPORT='0'
export NCCL_IB_DISABLE='1'

source ~/pyenv
ml purge
ml use $OTHERSTAGES
ml Stages/2019a
ml GCC/8.3.0
ml ParaStationMPI/5.4.4-1-CUDA
ml CUDA/10.1.105
ml NCCL/2.4.6-1-CUDA-10.1.105
ml cuDNN/7.5.1.10-CUDA-10.1.105
export NCCL_DEBUG=INFO
export NCCL_IB_CUDA_SUPPORT=0
export NCCL_IB_DISABLE=1
srun --cpu-bind=none,v --accel-bind=gn python -u sample.py 
