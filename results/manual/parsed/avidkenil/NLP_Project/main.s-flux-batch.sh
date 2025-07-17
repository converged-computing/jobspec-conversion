#!/bin/bash
#FLUX: --job-name=train_MT
#FLUX: -t=900
#FLUX: --urgency=16

module load python3/intel/3.6.3
source /home/dam740/pytorch_venv/bin/activate
python main.py --epochs 1\
               --batch-size 32\
               --num-directions 1\
               --encoder-num-layers 1\
               --decoder-num-layers 1\
               --encoder-emb-size 30\
               --decoder-emb-size 30\
               --encoder-hid-size 50\
               --beam-size 5\
               --target-vocab 10000\
               --max-len-source 100\
               --max-len-target 100\
               --teacher-forcing-prob 0.5\
               --num-directions 2
