#!/bin/bash
#FLUX: --job-name=siampose
#FLUX: --queue=gpu
#FLUX: --urgency=16

export PYTHONPATH='$ROOT:$PYTHONPATH'

date
module load anaconda3/5.3.0 cuda/9.0 cudnn/7.3.0
source activate pytorch0.4
ROOT=/cluster/home/it_stu1/bdclub/SiamRCNN/
export PYTHONPATH=$ROOT:$PYTHONPATH
mkdir -p logs
python -u $ROOT/tools/train_siamrcnn.py \
    --config=config.json -b 1 \
    -j 8 --pretrain ../siampose_ct/checkpoint_e245.pth \
    --epochs 200 \
    --log logs/log.txt \
    2>&1 | tee logs/train.log
