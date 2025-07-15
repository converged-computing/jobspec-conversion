#!/bin/bash
#FLUX: --job-name=greedy
#FLUX: -t=259200
#FLUX: --priority=16

module load cuda-10.0
source activate dro
seeds=(15213 17747 17 53)
for run in 0 1 2 3; do
seed=${seeds[$run]}
python -u celeba.py --arch resnet18 \
     --batch_size 256 --epochs 50 \
    --loss 'dro_greedy' --lr 0.0001 --alpha 0.2 \
    --data_path ../data/celeba --model_path models/4_greedy_clean \
    --group_split 'confounder' \
    --run ${run} --seed ${seed}
done
