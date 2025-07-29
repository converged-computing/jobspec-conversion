#!/bin/bash
#FLUX: --job-name=hydra_resnet20s_CIFAR10_separate_seed
#FLUX: -c=4
#FLUX: -t=10200
#FLUX: --urgency=16

export PATH='$PATH:$HOME/anaconda3/bin'

module purge
module load GCC/6.4.0-2.28  OpenMPI/2.1.2
module load CUDA/10.0.130 cuDNN/7.5.0.56-CUDA-10.0.130
module load Python/3.8.5
export PATH=$PATH:$HOME/anaconda3/bin
source activate biprune
cd ~/hydra-structured
python3 train.py --arch resnet20s --dataset CIFAR10 --k ${k} --exp-mode finetune --exp-name resnet20s_ratio${k}_adv_auto --trainer adv --val-method adv --source-net results/resnet20s/resnet20s_ratio${k}_adv_auto/prune/latest_exp/checkpoint/model_best.pth.tar --scaled-score-init --result-dir results --use_trainable_router --router_arch resnet20s
scontrol show job $SLURM_JOB_ID     ### write job information to output file
