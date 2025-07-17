#!/bin/bash
#FLUX: --job-name=field_imnn
#FLUX: -c=10
#FLUX: --queue=gpu
#FLUX: -t=10800
#FLUX: --urgency=16

module load  gcc/7.4.0 cuda/10.1.243_418.87.00 cudnn/v7.6.2-cuda-10.1 nccl/2.4.2-cuda-10.1 python3/3.7.3
source ~/anaconda3/bin/activate pyimnn
python3 field_run.py $SLURM_ARRAY_TASK_ID 
