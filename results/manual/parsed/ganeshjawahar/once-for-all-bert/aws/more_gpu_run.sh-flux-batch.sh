#!/bin/bash
#FLUX: --job-name=moresh
#FLUX: -c=10
#FLUX: --queue=a100
#FLUX: -t=1500000
#FLUX: --priority=16

export NCCL_NSOCKS_PERTHREAD='4'
export NCCL_SOCKET_NTHREADS='2'
export NCC_INFO='INFO'
export SL_NUM_NODES='2'
export PYTHONPATH='$(pwd)'

export NCCL_NSOCKS_PERTHREAD=4
export NCCL_SOCKET_NTHREADS=2
export NCC_INFO=INFO
module purge
conda activate basic
export SL_NUM_NODES=2
export PYTHONPATH=$(pwd)
echo $SLURMD_NODENAME $SLURM_JOB_ID $CUDA_VISIBLE_DEVICES $SLURM_LOCALID
srun --label /fsx/ganayu/code/SuperShaper/aws/more_commands.sh
