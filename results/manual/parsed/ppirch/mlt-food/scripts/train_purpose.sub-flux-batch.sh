#!/bin/bash
#FLUX: --job-name=train_purpose
#FLUX: -c=4
#FLUX: --queue=gpu
#FLUX: -t=604800
#FLUX: --priority=16

module load anaconda3
source activate food-regression
cd /project/jakarin.c/food-regression/
BATCH_SIZE=256
SEED=13
EPOCHS=25
backbones=(resnet50 resnet101 resnet152)
SECONDS=0
model_types=(shared concat)
loss_types=(uncertainty automatic)
for model_type in "${model_types[@]}"; do
    for backbone in "${backbones[@]}"; do
        for loss_type in "${loss_types[@]}"; do
            echo "Training $model_type $backbone $loss_type $SEED $EPOCHS"
            python training.py --model_type $model_type --backbone $backbone --loss_type $loss_type --batch_size $BATCH_SIZE --seed $SEED --epochs $EPOCHS
            echo "===================================================================================================="
        done
    done
done
duration=$SECONDS
echo "$(($duration / 60)) minutes and $(($duration % 60)) seconds elapsed."
