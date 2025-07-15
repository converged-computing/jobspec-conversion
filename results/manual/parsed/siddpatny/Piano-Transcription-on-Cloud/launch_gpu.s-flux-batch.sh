#!/bin/bash
#FLUX: --job-name=onsetsResume
#FLUX: -c=10
#FLUX: -t=32400
#FLUX: --priority=16

module load python3/intel/3.6.3 cuda/9.0.176 nccl/cuda9.0/2.4.2
python train.py with logdir=runs/model iterations=1000000 resume_iteration=25000
