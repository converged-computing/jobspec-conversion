#!/bin/bash
#FLUX: --job-name=conspicuous-peas-8631
#FLUX: -c=4
#FLUX: --queue=gpu
#FLUX: --priority=16

module load Anaconda3/5.3.0
module load cuDNN/7.6.4.38-gcccuda-2019b
source activate torch
python main.py --PROGRESS_BAR=0 --USE_COMPILE=1 --LOG='tensorboard/16HEAD' --ATTN_HEAD=16
