#!/bin/bash
#FLUX: --job-name=train_P100
#FLUX: --queue=gpu
#FLUX: -t=360000
#FLUX: --priority=16

module load anaconda/5.1.0-Python3.6-gcc5
module load cudnn/7.6.5-cuda10.1
module load tensorflow/2.3.0
python Training/train.py \
    --model_name "UV_GAN_1" \
    --display_iter 50000 \
    --max_iter 500000 \
    --batch_size 1 \
    --tol 3 \
    --input "aia.np_path_normal" \
    --output "hmi.np_path_normal" \
    --connector "aia.id" "hmi.aia_id" \
