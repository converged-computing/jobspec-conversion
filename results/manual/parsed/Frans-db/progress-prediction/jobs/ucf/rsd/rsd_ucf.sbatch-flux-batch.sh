#!/bin/bash
#FLUX: --job-name=stanky-parrot-5151
#FLUX: -c=2
#FLUX: --queue=general
#FLUX: -t=3600
#FLUX: --urgency=16

module use /opt/insy/modulefiles
module load cuda/10.0 cudnn/10.0-7.4.2.24
srun python /home/nfs/fransdeboer/mscfransdeboer/code/main.py \
    --seed 42 \
    --wandb_group normal \
    --wandb_tags optimized \
    --dataset ucf24 \
    --data_dir features/resnet152 \
    --feature_dim 2048 \
    --rsd_type minutes \
    --fps 25 \
    --rsd_normalizer 5 \
    --train_split train_tubes.txt \
    --test_split test_tubes.txt \
    --batch_size 1 \
    --iterations 30000 \
    --network rsdnet \
    --dropout_chance 0.3 \
    --lr_decay 0.1 \
    --lr_decay_every 10000 \
    --log_every 100 \
    --test_every 5000
