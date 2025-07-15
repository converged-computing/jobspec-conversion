#!/bin/bash
#FLUX: --job-name=muffled-despacito-1525
#FLUX: -c=4
#FLUX: --queue=long
#FLUX: -t=604800
#FLUX: --priority=16

MODEL=(cifar_vgg_16_64 cifar_resnet_20_64)
DATASET=(svhn cifar100)
REPLICATE=($(seq 1 1 10))
source ./open_lth/slurm-setup.sh svhn cifar100
cd open_lth
parallel --delay=15 --linebuffer --jobs=3  \
    python open_lth.py lottery  \
        --default_hparams={2}  \
        --dataset_name={3}  \
        --replicate={1}  \
        --levels=0  \
        --training_steps=160ep  \
        --save_every_n_epochs=10  \
        --batchnorm_replace="layernorm"  \
        --pretrain  \
            --pretrain_dataset_name={3}  \
            --pretrain_warmup_steps="1ep"  \
            --pretrain_training_steps=10ep  \
            --pretrain_save_every_n_epochs=1  \
  ::: ${REPLICATE[@]}  \
  ::: ${MODEL[@]}  \
  ::: ${DATASET[@]}  \
