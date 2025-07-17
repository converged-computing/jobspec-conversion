#!/bin/bash
#FLUX: --job-name=crusty-destiny-3015
#FLUX: -c=16
#FLUX: --urgency=16

source /etc/profile
module load anaconda cuda
python src/run_TCT.py --dataset cifar10 --architecture small_resnet14 --rounds_stage1 200 --rounds_stage2 0 --local_epochs_stage1 5 --local_lr_stage1 0.01 --samples_per_client 10000 --momentum 0.9 --use_data_augmentation  --save_dir experiments --data_dir ../data --use_fedprox --fedprox_mu 0.1
python src/run_TCT.py --dataset cifar100 --architecture small_resnet14 --rounds_stage1 200 --rounds_stage2 0 --local_epochs_stage1 5 --local_lr_stage1 0.01 --samples_per_client 10000 --momentum 0.9 --use_data_augmentation  --save_dir experiments --data_dir ../data --use_fedprox --fedprox_mu 0.1
python src/run_TCT.py --dataset fitzpatrick --architecture efficientnet-b1 --rounds_stage1 200 --rounds_stage2 0 --local_epochs_stage1 5 --local_lr_stage1 0.001 --momentum 0.9 --batch_size 64 --use_data_augmentation --save_dir experiments --data_dir ../data --pretrained --use_fedprox --fedprox_mu 0.1
