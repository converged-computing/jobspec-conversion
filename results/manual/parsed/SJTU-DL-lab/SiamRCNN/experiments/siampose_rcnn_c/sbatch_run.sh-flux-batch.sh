#!/bin/bash
#FLUX: --job-name=stanky-lentil-2783
#FLUX: --priority=16

export PYTHONPATH='$ROOT:$PYTHONPATH'

date
module load anaconda3/5.3.0 cuda/9.0 cudnn/7.3.0
source activate pytorch0.4
ROOT=/cluster/home/it_stu1/bdclub/SiamRCNN/
export PYTHONPATH=$ROOT:$PYTHONPATH
mkdir -p logs
python -u $ROOT/tools/train_siamrcnn.py \
    --config=config.json -b 1 \
    -j 4 --resume ./snapshot/checkpoint_e90.pth \
    --epochs 200 \
    --log logs/log.txt \
    2>&1 | tee logs/train.log
