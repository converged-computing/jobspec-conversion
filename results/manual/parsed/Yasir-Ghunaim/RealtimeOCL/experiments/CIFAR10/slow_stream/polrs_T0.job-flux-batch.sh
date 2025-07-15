#!/bin/bash
#FLUX: --job-name=rainbow-rabbit-1427
#FLUX: -c=6
#FLUX: --queue=batch
#FLUX: -t=3600
#FLUX: --priority=16

module purge
module load gcc/11.1.0
conda activate realtime_ocl
cd ../../..
python main.py \
--dataset 'cifar10' \
--batch_size 10 \
--lr 0.005 \
--lr_type 'polrs' \
--batch_delay 0 \
--gradient_steps 1 \
--output_dir '/path/to/tensorboard/output' \
--workers 4 \
--method 'ER' \
--seed 123 \
--size_replay_buffer 100
