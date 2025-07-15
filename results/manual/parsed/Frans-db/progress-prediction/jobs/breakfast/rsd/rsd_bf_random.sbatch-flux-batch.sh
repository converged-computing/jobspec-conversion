#!/bin/bash
#FLUX: --job-name=persnickety-nunchucks-1548
#FLUX: -c=2
#FLUX: --queue=general
#FLUX: -t=14400
#FLUX: --priority=16

module use /opt/insy/modulefiles
module load cuda/10.0 cudnn/10.0-7.4.2.24
srun python /home/nfs/fransdeboer/mscfransdeboer/code/main.py \
    --seed 42 \
    --wandb_group random \
    --wandb_tags fold_${SLURM_ARRAY_TASK_ID} optimized \
    --dataset breakfast \
    --data_dir features/resnet152_sampled_${SLURM_ARRAY_TASK_ID} \
    --feature_dim 2048 \
    --rsd_type minutes \
    --fps 1 \
    --rsd_normalizer 1250 \
    --train_split train_s${SLURM_ARRAY_TASK_ID}.txt \
    --test_split test_s${SLURM_ARRAY_TASK_ID}.txt \
    --batch_size 1 \
    --iterations 30000 \
    --network rsdnet \
    --dropout_chance 0.3 \
    --lr_decay 0.1 \
    --lr_decay_every 10000 \
    --log_every 100 \
    --test_every 1000 \
    --random
