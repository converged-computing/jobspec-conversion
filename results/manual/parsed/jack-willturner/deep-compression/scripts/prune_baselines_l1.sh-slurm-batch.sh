#!/bin/bash
#FLUX: --job-name=prune_baselines
#FLUX: -t=600000
#FLUX: --urgency=16

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
    python prune.py --pruner L1Pruner --model='resnet18' --data_loc="../datasets/cifar10" --seed=$seed --n_gpus=1 &
    python prune.py --pruner L1Pruner --model='resnet34' --data_loc="../datasets/cifar10" --seed=$seed --n_gpus=1 &
    python prune.py --pruner L1Pruner --model='resnet50' --data_loc="../datasets/cifar10" --seed=$seed --n_gpus=1
    python prune.py --pruner L1Pruner --model='wrn_40_2' --data_loc="../datasets/cifar10" --seed=$seed --n_gpus=1 &
    python prune.py --pruner L1Pruner --model='wrn_16_2' --data_loc="../datasets/cifar10" --seed=$seed --n_gpus=1 &
    python prune.py --pruner L1Pruner --model='wrn_40_1' --data_loc="../datasets/cifar10" --seed=$seed --n_gpus=1
done
