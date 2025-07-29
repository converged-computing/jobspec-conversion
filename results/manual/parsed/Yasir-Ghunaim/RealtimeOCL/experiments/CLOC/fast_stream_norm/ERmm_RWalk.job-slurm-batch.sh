#!/bin/bash
#FLUX: --job-name=ERmmRWalk
#FLUX: -c=12
#FLUX: --queue=batch
#FLUX: -t=144000
#FLUX: --urgency=16

module purge
module load gcc/11.1.0
conda activate realtime_ocl
cd ../../..
python main.py \
--dataset 'cloc' \
--batch_size 128 \
--lr 0.005 \
--lr_type 'constant' \
--batch_delay 1 \
--gradient_steps 2 \
--output_dir '/path/to/tensorboard/output' \
--workers 12 \
--method 'ER' \
--seed 123 \
--dataset_root '/path/to/CLOC/release/' \
--size_replay_buffer 40000 \
--pretrained
