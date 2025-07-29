#!/bin/bash
#SBATCH --mail-user=chenhang20@mails.tsinghua.edu.cn
#SBATCH --mail-type=all
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=4
#SBATCH --partition=gpu
#SBATCH: --no-requeue

export NCCL_SOCKET_IFNAME='eth0'
export NCCL_IB_DISABLE='1'

export NCCL_SOCKET_IFNAME=eth0
export NCCL_IB_DISABLE=1
module load cuda/10.0
srun python train.py -c $1 --gpus 4 --nodes 1 2>&1 | tee /data/home/scv1134/run/chenhang/nichang-avdomain/egs/frcnn2_para/$2.log
