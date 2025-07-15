#!/bin/bash
#FLUX: --job-name=cad_cifar
#FLUX: --queue=gpu
#FLUX: -t=43200
#FLUX: --priority=16

module load anaconda/3.7
source activate /home/kong_04/project/envs/cad
cd $SLURM_SUBMIT_DIR
MODEL=ResNet12
METHOD=cad # lr=0.003 
for DATA in  cifarfs #tieredImagenet CUB cifarfs cross
do
    NSHOT=1
    python train.py --dataset $DATA --model $MODEL --method $METHOD --n_shot $NSHOT --train_aug --stop_epoch 300 --optim adam --lr 0.003 --milestones 300
    # #save features
    python save_features.py --dataset $DATA --model $MODEL --method $METHOD --n_shot $NSHOT --split novel --train_aug --save_iter -1
    # #test model
    python test.py --dataset $DATA --model $MODEL --method $METHOD --n_shot $NSHOT --split novel --train_aug --save_iter -1
    NSHOT=5
    python train.py --dataset $DATA --model $MODEL --method $METHOD --n_shot $NSHOT --train_aug --stop_epoch 200 --optim adam --lr 0.003 --milestones 200
    # #save features
    python save_features.py --dataset $DATA --model $MODEL --method $METHOD --n_shot $NSHOT --split novel --train_aug --save_iter -1
    # #test model
    python test.py --dataset $DATA --model $MODEL --method $METHOD --n_shot $NSHOT --split novel --train_aug --save_iter -1 
done
