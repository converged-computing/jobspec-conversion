#!/bin/bash
#SBATCH --job-name=pro2
#SBATCH --output=LOG-%x.%j-OUTPUT.txt
#SBATCH --error=LOG-%x.%j-ERROR.txt
#SBATCH --nodes=8
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:4
#SBATCH --time=2-00:10:00
#SBATCH --constraint=ntasks-per-node=1
#SBATCH --chdir=/home/bingxing2/home/scx6069/zzr/code/proj/d3/code/output/log/pro2/

export GPUS_PER_NODE='4'
export NCCL_ALGO='Ring'
export NCCL_MAX_NCHANNELS='16'
export NCCL_MIN_NCHANNELS='16'
export NCCL_DEBUG='INFO'
export NCCL_TOPO_FILE='/home/bingxing2/apps/nccl/conf/dump.xml'
export NCCL_IB_HCA='mlx5_0,mlx5_2'
export NCCL_IB_GID_INDEX='3'
export NCCL_IB_TIMEOUT='23'
export NCCL_IB_RETRY_CNT='7'

module load anaconda/2021.11
module load compilers/cuda/12.2
module load cudnn/8.9.5.29_cuda12.x
module load compilers/gcc/12.2.0
export GPUS_PER_NODE=4
export NCCL_ALGO=Ring
export NCCL_MAX_NCHANNELS=16
export NCCL_MIN_NCHANNELS=16
export NCCL_DEBUG=INFO
export NCCL_TOPO_FILE=/home/bingxing2/apps/nccl/conf/dump.xml
export NCCL_IB_HCA=mlx5_0,mlx5_2
export NCCL_IB_GID_INDEX=3
export NCCL_IB_TIMEOUT=23
export NCCL_IB_RETRY_CNT=7
