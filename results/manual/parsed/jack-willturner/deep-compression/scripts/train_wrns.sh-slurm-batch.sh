#!/bin/bash
#SBATCH --job-name=baselines
#SBATCH --output=logs/baselines.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:3
#SBATCH --mem=42000
#SBATCH --time=6-22:40:00

export PATH='$HOME/miniconda/bin:$PATH'
export DATA_LOC='../datasets/cifar10'

export PATH="$HOME/miniconda/bin:$PATH"
export DATA_LOC="../datasets/cifar10"
cd ..
source activate bertie
echo 'bertie activated'
nvidia-smi
for seed in 1 2 3
do
    python train.py --model='wrn_40_2' --data_loc="../datasets/cifar10" --seed=$seed --n_gpus=1 &
    python train.py --model='wrn_16_2' --data_loc="../datasets/cifar10" --seed=$seed --n_gpus=1 &
    python train.py --model='wrn_40_1' --data_loc="../datasets/cifar10" --seed=$seed --n_gpus=1
done
