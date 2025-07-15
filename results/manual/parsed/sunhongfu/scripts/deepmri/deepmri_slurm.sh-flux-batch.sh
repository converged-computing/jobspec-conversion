#!/bin/bash
#FLUX: --job-name=xuanyu_test_tensor_gpu
#FLUX: --queue=gpu
#FLUX: --priority=16

module load cuda/9.2.148.1
module load gnu7
module load mvapich2
module load anaconda/3.6
module load pmix
srun -n2 python3.6 train.py --patch_height=48 --patch_width=48 --patch_depth=48 --data_path /scratch/itee/uqxuanyu/Dataset
