#!/bin/bash
#FLUX: --job-name=hairy-rabbit-4829
#FLUX: --urgency=16

export LD_LIBRARY_PATH='$LD_LIBRARY_PATH:$CUDNN_ROOT/lib64:$CUDA_HOME/lib64:/lustre/ssingh37/Acads/CMSC818x/nccl/build/lib'

cd /lustre/ssingh37/Acads/CMSC818x/wait-free-backprop
module load cuda
module load cudnn/gcc
module load openmpi/gcc
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$CUDNN_ROOT/lib64:$CUDA_HOME/lib64:/lustre/ssingh37/Acads/CMSC818x/nccl/build/lib
NCCL_IB_DISABLE=1 NCCL_SOCKET_IFNAME=eno1 mpirun ./multi_GPU_wfbp
