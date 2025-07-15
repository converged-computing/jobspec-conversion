#!/bin/bash
#FLUX: --job-name=muffled-knife-7922
#FLUX: --urgency=16

module load python/3.6.4_gcc5_np1.14.5
module load cuda/9.0
cd $SCRATCH/yolact
python3 train.py --config $1 --batch_size $2 --resume=$3 --save_interval 5000 --start_iter=-1 >>logs/$1_log 2>&1
