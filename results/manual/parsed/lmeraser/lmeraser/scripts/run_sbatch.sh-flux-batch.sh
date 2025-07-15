#!/bin/bash
#FLUX: --job-name=your_job_name
#FLUX: --queue=your_partition_name
#FLUX: -t=43200
#FLUX: --priority=16

export CUDA_VISIBLE_DEVICES='0,1,2,3,4,5,6,7'
export MASTER_ADDR='localhost'
export MASTER_PORT='1234'
export WORLD_SIZE='8'
export NCLL_BLOCKING_WAIT='1'
export NCCL_TIMEOUT='200'
export BATCH_SIZE='yout_batch_size(int)'
export EPOCHS='yout_epochs(int)'
export LR='yout_lr(float)'
export WEIGHT_DECAY='yout_weight_decay(float)'
export OMP_NUM_THREADS='1'

cd /path/to/your/workspace
export CUDA_VISIBLE_DEVICES=0,1,2,3,4,5,6,7
export MASTER_ADDR=localhost
export MASTER_PORT=1234
export WORLD_SIZE=8
export NCLL_BLOCKING_WAIT=1
export NCCL_TIMEOUT=200
export BATCH_SIZE=yout_batch_size(int)
export EPOCHS=yout_epochs(int)
export LR=yout_lr(float)
export WEIGHT_DECAY=yout_weight_decay(float)
export OMP_NUM_THREADS=1
load module your_module_name
/your/torchrun \
    --nproc_per_node=8 \
    eraser/main.py \
    --batch_size $BATCH_SIZE \
    --base_dir /path/to/your/dataset \
    --pretrained_model vit-b-22k \
    --erasing_method lmeraser \
    --epochs $EPOCHS \
    --lr $LR \
    --weight_decay $WEIGHT_DECAY \
    --test_dataset cifar100 \
    --num_gpus 8 \
    --num_workers 4 \
    --distributed
