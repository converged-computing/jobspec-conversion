#!/bin/bash
#FLUX: --job-name=eg
#FLUX: -t=0
#FLUX: --urgency=16

module load cuda-10.0
source activate dro
seeds=(15213 17747 17 53)
for run in 0 1 2 3; do
seed=${seeds[$run]}
python -u celeba.py --arch resnet18 \
     --batch_size 256 --epochs 50 \
    --loss 'dro_eg' --lr 0.0001 --lr_eg 0.01 --reweight \
    --data_path ../data/celeba --model_path models/2_eg_clean \
    --group_split 'confounder' \
    --run ${run} --seed ${seed}
done
