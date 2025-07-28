#!/bin/bash
#FLUX: --job-name=JQR
#FLUX: -c=12
#FLUX: -t=360000
#FLUX: --urgency=16

module load python/intel/3.8.6
module load cuda/11.1.74
python3.8 -m torch.distributed.launch --nproc_per_node=4 --master_port 6666 train.py 
