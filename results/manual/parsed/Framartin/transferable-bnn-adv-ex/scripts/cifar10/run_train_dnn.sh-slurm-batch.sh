#!/bin/bash
#FLUX: --job-name=TrainDNN
#FLUX: -c=4
#FLUX: --queue=gpu
#FLUX: -t=86400
#FLUX: --urgency=16

command -v module >/dev/null 2>&1 && module load lang/Python
source venv/bin/activate
set -x
ARGS='--num-workers 4'
print_time() {
  duration=$SECONDS
  echo "$(($duration / 60)) minutes and $(($duration % 60)) seconds elapsed."
  SECONDS=0
  SEED=$(($SEED+1))
}
SECONDS=0
SEED=100  # different than target dnn
python -u train.py ./models CIFAR10 PreResNet110 Adam --lr 0.01 --lr-decay 75 --lr-decay-gamma 0.1 --prior-sigma 100 --epochs 250 --seed $SEED $ARGS
print_time # 216 minutes
python -u train.py ./models CIFAR10 VGG16BN Adam --lr 0.01 --lr-decay 75 --lr-decay-gamma 0.1 --prior-sigma 100 --epochs 250 --seed $SEED $ARGS
print_time # 60 minutes
python -u train.py ./models CIFAR10 VGG19BN Adam --lr 0.01 --lr-decay 75 --lr-decay-gamma 0.1 --prior-sigma 100 --epochs 250 --seed $SEED $ARGS
print_time # 68 minutes
python -u train.py ./models CIFAR10 PreResNet164 Adam --lr 0.01 --lr-decay 75 --lr-decay-gamma 0.1 --prior-sigma 100 --epochs 250 --seed $SEED $ARGS
print_time # 325 minutes
python -u train.py ./models CIFAR10 WideResNet28x10 Adam --lr 0.01 --lr-decay 75 --lr-decay-gamma 0.1 --prior-sigma 100 --epochs 250 --seed $SEED $ARGS
print_time # 460 minutes
