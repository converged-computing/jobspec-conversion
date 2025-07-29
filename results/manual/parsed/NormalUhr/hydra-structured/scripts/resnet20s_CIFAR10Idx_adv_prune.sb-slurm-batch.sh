#!/bin/bash
#SBATCH --job-name=hydra_resnet20s_CIFAR10_separate_seed
#SBATCH --output=log/slurm/resnet20s_CIFAR10_separate_seed.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --gres=gpu:v100:1
#SBATCH --mem=2G
#SBATCH --time=01:20:00
#SBATCH --exclude=lac-143

export PATH='$PATH:$HOME/anaconda3/bin'

module purge
module load GCC/6.4.0-2.28  OpenMPI/2.1.2
module load CUDA/10.0.130 cuDNN/7.5.0.56-CUDA-10.0.130
module load Python/3.8.5
export PATH=$PATH:$HOME/anaconda3/bin
source activate biprune
cd ~/hydra-structured
python3 train.py --arch resnet20s --dataset CIFAR10Idx --dataset-idx ${idx} --k ${k} --exp-mode prune --dataset-idx-method wrn --exp-name resnet20s_idx${idx}_wrn_ratio${k}_adv --trainer adv --val-method adv --source-net results/pretrained/resnet20s_adv_pretrain.pth.tar --scaled-score-init --result-dir results
scontrol show job $SLURM_JOB_ID     ### write job information to output file
