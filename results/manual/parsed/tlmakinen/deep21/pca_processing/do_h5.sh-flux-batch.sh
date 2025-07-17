#!/bin/bash
#FLUX: --job-name=collect_dat
#FLUX: --queue=cca
#FLUX: -t=2400
#FLUX: --urgency=16

module load  gcc/7.4.0 cuda/10.1.243_418.87.00 cudnn/v7.6.2-cuda-10.1 nccl/2.4.2-cuda-10.1 python3/3.7.3
source ~/anaconda3/bin/activate tf_gpu
python3 make_h5.py $SLURM_ARRAY_TASK_ID /mnt/home/tmakinen/repositories/deep21/configs/
