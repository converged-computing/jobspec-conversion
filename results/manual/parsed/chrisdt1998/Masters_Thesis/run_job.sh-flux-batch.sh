#!/bin/bash
#FLUX: --job-name=vit_with_pruning_importance_test
#FLUX: -c=3
#FLUX: -t=28800
#FLUX: --priority=16

module load gcc
module load python
module load cuda/11.0
module load cudnn/8.0.5
python3 -m pip install --user torch
python3 -m pip install --user numpy
python3 -m pip install --user argparse
python3 -m pip install --user torchvision
python3 -m pip install --user tqdm
python3 -m pip install --user -e git+git://github.com/chrisdt1998/transformers.git@main
python3 -m pip install --user datasets
python3 -m pip install --user sklearn
python3 -m pip install --user tensorboardX
python3 -m pip install --user matplotlib
python3 -m pip install --user opendatasets
srun python3 /rwthfs/rz/cluster/home/rs062004/tmp/pycharm_project_109/no_train_masks.py --experiment_id=threshold_exp_no_train_cifar100 --iteration_id=threshold_20 --pruning_threshold=0.20 --dataset_name=cifar100 --prune_whole_layers
srun python3 /rwthfs/rz/cluster/home/rs062004/tmp/pycharm_project_109/no_train_masks.py --experiment_id=threshold_exp_no_train_cifar100 --iteration_id=threshold_40 --pruning_threshold=0.40 --dataset_name=cifar100 --prune_whole_layers
srun python3 /rwthfs/rz/cluster/home/rs062004/tmp/pycharm_project_109/no_train_masks.py --experiment_id=threshold_exp_no_train_cifar100 --iteration_id=threshold_60 --pruning_threshold=0.60 --dataset_name=cifar100 --prune_whole_layers
srun python3 /rwthfs/rz/cluster/home/rs062004/tmp/pycharm_project_109/no_train_masks.py --experiment_id=threshold_exp_no_train_cifar100 --iteration_id=threshold_80 --pruning_threshold=0.80 --dataset_name=cifar100 --prune_whole_layers
srun python3 /rwthfs/rz/cluster/home/rs062004/tmp/pycharm_project_109/no_train_masks.py --experiment_id=threshold_exp_no_train_cifar100 --iteration_id=threshold_90 --pruning_threshold=0.90 --dataset_name=cifar100 --prune_whole_layers
srun python3 /rwthfs/rz/cluster/home/rs062004/tmp/pycharm_project_109/no_train_masks.py --experiment_id=threshold_exp_no_train_cifar100 --iteration_id=threshold_100 --pruning_threshold=1.00 --dataset_name=cifar100 --prune_whole_layers
