#!/bin/bash
#FLUX: --job-name=delicious-truffle-5758
#FLUX: --urgency=16

DATASET="--train-dir /home/wang4538/DGMS-master/CIFAR10/train/ --val-dir /home/wang4538/DGMS-master/CIFAR10/val/ -d cifar10 --num-classes 10"
GENERAL="--lr 2e-5 --batch-size 128 --epochs 350 --workers 4 --base-size 32 --crop-size 32 --nesterov"
INFO="--checkname resnet322bit --lr-scheduler one-cycle"
MODEL="--network resnet32 --mask --K 4 --weight-decay 5e-4 --empirical True"
PARAMS="--tau 0.01"
RESUME="--show-info"
GPU="--gpu-ids 0"
sbatch --time=4:00:00 --nodes=1 --gpus-per-node=1 <<EOT
nvidia-smi
python ../main.py $DATASET $GENERAL $MODEL $INFO $PARAMS $RESUME $GPU
EOT
