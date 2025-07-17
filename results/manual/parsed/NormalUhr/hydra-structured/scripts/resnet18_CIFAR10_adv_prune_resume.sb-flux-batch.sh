#!/bin/bash
#FLUX: --job-name=hydra_resnet18_CIFAR10_separate_seed
#FLUX: -c=4
#FLUX: -t=6000
#FLUX: --urgency=16

export PATH='$PATH:$HOME/anaconda3/bin'

module purge
module load GCC/6.4.0-2.28  OpenMPI/2.1.2
module load CUDA/10.0.130 cuDNN/7.5.0.56-CUDA-10.0.130
module load Python/3.8.5
export PATH=$PATH:$HOME/anaconda3/bin
source activate biprune
cd ~/hydra-structured
python3 train.py --arch resnet18 --dataset CIFAR10 --k ${k} --exp-mode prune --exp-name resnet18_ratio${k}_adv --trainer adv --val-method adv --resume results/resnet18/resnet18_ratio${k}_adv/prune/latest_exp/checkpoint/checkpoint.pth.tar --scaled-score-init --result-dir results
scontrol show job $SLURM_JOB_ID     ### write job information to output file
