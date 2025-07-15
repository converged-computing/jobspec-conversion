#!/bin/bash
#FLUX: --job-name=ch_20
#FLUX: -t=144000
#FLUX: --priority=16

cd /scratch/msy290/maml_resnet_20way/
module load cudnn/8.0v6.0
module load cuda/8.0.44
module load tensorflow/python3.6/1.3.0
python main.py --datasource=omniglot --metatrain_iterations=40000 --meta_batch_size=16 --update_batch_size=1 --num_classes=20 --update_lr=0.1  --num_updates=5 --logdir=logs/omniglot20way/  >> log_train.txt
python main.py --datasource=omniglot --metatrain_iterations=40000 --meta_batch_size=16 --update_batch_size=1 --num_classes=20 --update_lr=0.1  --num_updates=5 --logdir=logs/omniglot20way/ --train=False --test_set=True >> log_test.txt
