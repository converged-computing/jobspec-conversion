#!/bin/bash
#FLUX: --job-name=pro3
#FLUX: -N=8
#FLUX: -t=173400
#FLUX: --urgency=16

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
PYPHRUN=/home/bingxing2/home/scx6069/zzr/pynlfff/pynlfff/pycomputer/gpu/run_grid1.py
LOP=/home/bingxing2/home/scx6069/zzr/data/nlfff_append/run2/rlog
mkdir -p $LOP
nohup python $PYPHRUN 5 0 >> $LOP/log5.txt &
nohup python $PYPHRUN 6 1 >> $LOP/log6.txt &
nohup python $PYPHRUN 7 2 >> $LOP/log7.txt &
nohup python $PYPHRUN 8 3 >> $LOP/log8.txt &
while true; do
    # top -n 1 >> "$output_file"
    # echo "--------------------------------------" >> "$output_file"
    top -n 1
    echo "--------------------------------------"
    # sleep 6  
    date
    sleep 600  # 休眠10分钟
done
