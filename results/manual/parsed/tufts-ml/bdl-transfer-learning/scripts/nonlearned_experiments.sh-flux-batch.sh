#!/bin/bash
#FLUX: --job-name=bumfuzzled-sundae-7956
#FLUX: --priority=16

source ~/.bashrc
conda activate bdl-transfer-learning
experiments=(
    "python ../src/CIFAR10_main.py --dataset_path='/cluster/tufts/hugheslab/eharve06/CIFAR-10' --experiments_path='/cluster/tufts/hugheslab/eharve06/bdl-transfer-learning/experiments/retrained_CIFAR-10_torchvision' --lr_0=0.01 --model_name='nonlearned_lr_0=0.01_n=10_random_state=1001_weight_decay=0.01' --n=10 --prior_path='/cluster/tufts/hugheslab/eharve06/resnet50_torchvision' --prior_type='nonlearned' --random_state=1001 --wandb --wandb_project='retrained_CIFAR-10_torchvision' --weight_decay=0.01"
    "python ../src/CIFAR10_main.py --dataset_path='/cluster/tufts/hugheslab/eharve06/CIFAR-10' --experiments_path='/cluster/tufts/hugheslab/eharve06/bdl-transfer-learning/experiments/retrained_CIFAR-10_torchvision' --lr_0=0.0001 --model_name='nonlearned_lr_0=0.0001_n=10_random_state=2001_weight_decay=0.01' --n=10 --prior_path='/cluster/tufts/hugheslab/eharve06/resnet50_torchvision' --prior_type='nonlearned' --random_state=2001 --wandb --wandb_project='retrained_CIFAR-10_torchvision' --weight_decay=0.01"
)
eval "${experiments[$SLURM_ARRAY_TASK_ID]}"
conda deactivate
