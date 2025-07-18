#!/bin/bash
#FLUX: --job-name=kfac-test
#FLUX: --urgency=16

export MASTER_ADDR='$(/usr/sbin/ip a show | grep inet | grep 192.168.205 | head -1 | cut -d " " -f 6 | cut -d "/" -f 1)'
export MASTER_PORT='3535'

. /etc/profile.d/modules.sh
module load cuda/11.1 cudnn/cuda-11.1/8.0 nccl/cuda-11.1/2.7.8 openmpi/3.1.6
export MASTER_ADDR=$(/usr/sbin/ip a show | grep inet | grep 192.168.205 | head -1 | cut -d " " -f 6 | cut -d "/" -f 1)
export MASTER_PORT=3535
mpirun -np 1 \
       python3 main.py \
       --dataset cifar10 \
       --optimizer kfac \
       --network alexnet \
       --epoch 50 \
       --milestone 20,40 \
       --learning_rate 0.001 \
       --damping 0.03 \
       --weight_decay 0.003 \
       --project kfac-test \
       --experiment kfac
