#!/bin/bash
#FLUX: --job-name=lovely-cattywampus-7647
#FLUX: -c=6
#FLUX: --queue=batch
#FLUX: -t=3600
#FLUX: --urgency=16

module purge
module load gcc/11.1.0
conda activate realtime_ocl
cd ../../..
python main.py \
--dataset 'cifar10' \
--batch_size 10 \
--lr 0.001 \
--lr_type 'constant' \
--batch_delay 1 \
--gradient_steps 1 \
--output_dir '/path/to/tensorboard/output' \
--workers 4 \
--method 'RWalk' \
--RWalk_warmup 0.05 \
--RWalk_update_freq 1000 \
--RWalk_ewc_lambda 2 \
--seed 123 \
--size_replay_buffer 100
