#!/bin/bash
#FLUX: --job-name=expressive-platanos-4829
#FLUX: -t=172800
#FLUX: --priority=16

module purge
module load centos7.3/lib/cuda/10.1
module load centos7.3/comp/gcc/6.4
/truba/home/akindiroglu/Workspace/Libs/pytorch_nightly/bin/python main.py \
 --model_type 'GCN' \
 --pretrained_model ''  \
 --num_workers 0 \
 --num_epochs 750 \
 --batch_size 16 \
 --dropout 0 \
 --max_num_classes -1 \
 --iterations_per_epoch 300 \
 --display_batch_progress \
 --transfer_method 'combined' \
 --transfer_train_source 'AUTSL_train_whole' \
 --transfer_train_target 'bsign22k_train_shared'\
 --transfer_validation 'bsign22k_val_shared'\
 --experiment_notes ''
