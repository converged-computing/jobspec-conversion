#!/bin/bash
#FLUX: --job-name=GPU-Test
#FLUX: --queue=batch-acc
#FLUX: -t=21600
#FLUX: --urgency=16

export CUDA_MPS_PIPE_DIRECTORY='/tmp/nvidia-mps'
export CUDA_MPS_LOG_DIRECTORY='/tmp/nvidia-log'

. /etc/profile.d/modules.sh
module purge
module load slurm
module load intel/compiler/64/15.0.0.090
module load intel/mkl/64/11.2
module load openmpi/intel/1.8.4
module load cuda/toolkit/7.5.18
if [ ! -d "/tmp/nvidia-mps" ] ; then
    mkdir "/tmp/nvidia-mps"
fi
export CUDA_MPS_PIPE_DIRECTORY="/tmp/nvidia-mps"
if [ ! -d "/tmp/nvidia-log" ] ; then
    mkdir "/tmp/nvidia-log"
fi
export CUDA_MPS_LOG_DIRECTORY="/tmp/nvidia-log"
nvidia-cuda-mps-control -d
python -u GPUTest.py
