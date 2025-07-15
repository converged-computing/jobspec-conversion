#!/bin/bash
#FLUX: --job-name=expe
#FLUX: -c=10
#FLUX: -t=72000
#FLUX: --urgency=16

cd ${SLURM_SUBMIT_DIR}
module purge
module unload cuda
module load cuda/11.2
module load pytorch-gpu/py3/1.10.0
set -x
srun python src/eval.py \
    --computer=jeanzay \
    --hardware=multi-gpu \
    --precision=mixed \
    --nb_workers=10 \
    --dataset_name=cifar10 \
    --resnet_type=resnet18 \
    --z_dim=128 \
    --nb_epochs_clsf=90 \
    --batch_size_clsf=256 \
    --lr_init_clsf=0.2 \
    --momentum_clsf=0.9 \
    --weight_decay_clsf=0.0 \
    --checkpoint=./checkpoints/weights_simclr_cifar10.pt \
