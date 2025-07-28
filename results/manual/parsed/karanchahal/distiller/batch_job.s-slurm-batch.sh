#!/bin/bash
#FLUX: --job-name=distillation
#FLUX: -t=86400
#FLUX: --urgency=16

module purge
module load python3/intel/3.7.3
cd /home/$USER/nyu-cv-project
pip3 install --user torch torchvision numpy pandas tqdm seaborn
python3 evaluate_kd.py --epochs 350 --teacher resnet18 --student resnet8  --dataset cifar10 --teacher-checkpoint pretrained/resnet18_cifar10_95500.pth --mode nokd kd fd oh rkd takd
