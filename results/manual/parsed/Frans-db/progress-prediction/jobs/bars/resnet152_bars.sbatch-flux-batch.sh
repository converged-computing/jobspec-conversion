#!/bin/bash
#FLUX: --job-name=tart-peanut-2730
#FLUX: -c=2
#FLUX: --queue=general
#FLUX: -t=14400
#FLUX: --priority=16

module use /opt/insy/modulefiles
module load cuda/10.0 cudnn/10.0-7.4.2.24
srun python /home/nfs/fransdeboer/mscfransdeboer/code/main.py \
    --seed 42 \
    --wandb_group normal \
    --experiment_name resnet_bars \
    --dataset bars \
    --data_dir rgb-images \
    --flat \
    --train_split train.txt \
    --test_split test.txt \
    --batch_size 48 \
    --iterations 50000 \
    --network rsdnet_flat \
    --backbone resnet18 \
    --load_backbone resnet18.pth \
    --dropout_chance 0.0 \
    --lr_decay 0.1 \
    --lr_decay_every 20000 \
    --log_every 100 \
    --test_every 25000 \
    --no_resize
