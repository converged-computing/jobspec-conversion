#!/bin/bash
#SBATCH --job-name=hydra_resnet18_CIFAR10_separate_seed
#SBATCH --output=log/slurm/resnet18_CIFAR10_separate_seed.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --gres=gpu:v100:1
#SBATCH --mem=2G
#SBATCH --time=01:50:00
#SBATCH --exclude=lac-143

export PATH='$PATH:$HOME/anaconda3/bin'

module purge
module load GCC/6.4.0-2.28  OpenMPI/2.1.2
module load CUDA/10.0.130 cuDNN/7.5.0.56-CUDA-10.0.130
module load Python/3.8.5
export PATH=$PATH:$HOME/anaconda3/bin
source activate biprune
cd ~/hydra-structured
python3 train.py --arch resnet18 --dataset CIFAR10 --k ${k} --exp-mode finetune --exp-name resnet18_ratio${k}_std_auto --trainer base --val-method base --resume results/resnet18/resnet18_ratio${k}_std_auto/finetune/latest_exp/checkpoint/checkpoint.pth.tar --result-dir results --use_trainable_router --router_arch resnet18
scontrol show job $SLURM_JOB_ID     ### write job information to output file
