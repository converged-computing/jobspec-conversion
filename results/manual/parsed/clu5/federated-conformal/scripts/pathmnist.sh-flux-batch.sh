#!/bin/bash
#FLUX: --job-name=blank-leg-2561
#FLUX: -c=16
#FLUX: --priority=16

source /etc/profile
module load anaconda cuda
python src/run_TCT.py --dataset pathmnist --architecture small_resnet14 --rounds_stage1 100 --rounds_stage2 100 --local_epochs_stage1 5  --local_lr_stage1 0.01 --local_steps_stage2 500 --local_lr_stage2 0.0001 --momentum 0.9 --use_data_augmentation --save_dir experiments --data_dir ../data
python src/run_TCT.py --dataset pathmnist --architecture small_resnet14 --rounds_stage1 200 --rounds_stage2 0 --local_epochs_stage1 5  --local_lr_stage1 0.01 --momentum 0.9 --use_data_augmentation --save_dir experiments --data_dir ../data
python src/run_TCT.py --dataset pathmnist --architecture small_resnet14 --rounds_stage1 200 --rounds_stage2 0 --local_epochs_stage1 1 --local_lr_stage1 0.01 --momentum 0.9 --use_data_augmentation --save_dir experiments --data_dir ../data --central
python src/run_TCT.py --dataset pathmnist --architecture small_resnet14 --rounds_stage1 100 --rounds_stage2 100 --local_epochs_stage1 5  --local_lr_stage1 0.01 --local_steps_stage2 500 --local_lr_stage2 0.0001 --momentum 0.9 --use_data_augmentation --save_dir experiments --data_dir ../data --use_iid_partition
python src/run_TCT.py --dataset pathmnist --architecture small_resnet14 --rounds_stage1 200 --rounds_stage2 0 --local_epochs_stage1 5  --local_lr_stage1 0.01 --momentum 0.9 --use_data_augmentation --save_dir experiments --data_dir ../data --use_iid_partition
