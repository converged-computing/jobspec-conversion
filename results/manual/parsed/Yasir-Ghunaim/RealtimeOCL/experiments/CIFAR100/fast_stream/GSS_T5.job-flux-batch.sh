#!/bin/bash
#FLUX: --job-name=GSS_T5
#FLUX: -c=6
#FLUX: --queue=batch
#FLUX: -t=3600
#FLUX: --urgency=16

module purge
module load gcc/11.1.0
conda activate realtime_ocl
cd ../../..
python main.py \
--dataset 'cifar100' \
--batch_size 10 \
--lr 0.005 \
--lr_type 'constant' \
--batch_delay 5 \
--gradient_steps 1 \
--output_dir '/path/to/tensorboard/output' \
--workers 4 \
--method 'GSS' \
--seed 123 \
--GSS_threshold 0.0 \
--GSS_mem_strength 10 \
--size_replay_buffer 100
