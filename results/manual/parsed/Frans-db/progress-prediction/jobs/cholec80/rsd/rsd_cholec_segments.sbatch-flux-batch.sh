#!/bin/bash
#FLUX: --job-name=chocolate-frito-6583
#FLUX: -c=2
#FLUX: --queue=general
#FLUX: -t=1800
#FLUX: --urgency=16

module use /opt/insy/modulefiles
module load cuda/10.0 cudnn/10.0-7.4.2.24
srun python /home/nfs/fransdeboer/mscfransdeboer/code/main.py \
    --seed 42 \
    --experiment_name rsd_cholec_segments_${SLURM_ARRAY_TASK_ID} \
    --wandb_group segments \
    --wandb_tags fold_${SLURM_ARRAY_TASK_ID} \
    --dataset cholec80 \
    --data_dir features/resnet152_${SLURM_ARRAY_TASK_ID} \
    --feature_dim 2048 \
    --rsd_type minutes \
    --fps 1 \
    --rsd_normalizer 5 \
    --train_split t12_${SLURM_ARRAY_TASK_ID}.txt \
    --test_split e_${SLURM_ARRAY_TASK_ID}.txt \
    --batch_size 1 \
    --iterations 30000 \
    --network rsdnet \
    --dropout_chance 0.3 \
    --lr_decay 0.1 \
    --lr_decay_every 10000 \
    --log_every 100 \
    --test_every 5000 \
    --subsample
