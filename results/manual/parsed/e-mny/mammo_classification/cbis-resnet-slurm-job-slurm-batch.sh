#!/bin/bash
#FLUX: --job-name=CBISresnet_mammo
#FLUX: -c=16
#FLUX: --queue=m3g
#FLUX: -t=255600
#FLUX: --urgency=16

EPOCHS="$1"
DATA_AUG="$2"
eval "$(conda shell.bash hook)"
conda activate exp1
if [ "$DATA_AUG" == "true" ]; then
    echo "Running script with data augmentation"
    srun --exclusive python main.py --model resnet50 --dataset CBIS-DDSM --num_epochs $EPOCHS --data_augment --early_stopping
else
    echo "Running script without data augmentation"
    srun --exclusive python main.py --model resnet50 --dataset CBIS-DDSM --num_epochs $EPOCHS --no-data_augment
fi
