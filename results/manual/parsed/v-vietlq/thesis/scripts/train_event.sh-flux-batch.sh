#!/bin/bash
#FLUX: --job-name=chocolate-arm-9593
#FLUX: --urgency=16

python train.py \
--name event_cnnlstm \
--num_classes 23 \
--backbone resnet101 \
--num_threads 16 \
--seed 2021 \
--train_root ~/datasets/CUFED/images \
--train_list filenames/train_single.txt \
--val_list filenames/val.txt \
--batch_size 4 \
--save_dir checkpoints \
--max_epoch 80 \
--optimizer adam \
--lr 1e-4 \
--weight_decay 1e-4 \
--lr_policy cosine \
--lr_milestones 30 50 70 90 100 110 \
--lr_gamma 0.5 \
--patience 20 \
--loss ce \
--gpus 0,1 \
--accelerator ddp
