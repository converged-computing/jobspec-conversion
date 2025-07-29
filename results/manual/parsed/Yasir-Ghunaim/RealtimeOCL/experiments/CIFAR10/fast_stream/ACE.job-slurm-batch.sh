#!/bin/bash
#FLUX: --job-name=ACE
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
--batch_delay 0 \
--gradient_steps 1 \
--output_dir '/path/to/tensorboard/output' \
--workers 4 \
--method 'ACE' \
--seed 123 \
--size_replay_buffer 100
