#!/bin/bash
#FLUX: --job-name=blank-muffin-1217
#FLUX: -c=2
#FLUX: --queue=general
#FLUX: -t=14400
#FLUX: --urgency=16

module use /opt/insy/modulefiles
module load cuda/10.0 cudnn/10.0-7.4.2.24
srun python /home/nfs/fransdeboer/mscfransdeboer/code/main.py \
    --seed 42 \
    --experiment_name lstm_bf_indices_${SLURM_ARRAY_TASK_ID} \
    --wandb_group indices \
    --wandb_tags fold_${SLURM_ARRAY_TASK_ID} \
    --dataset breakfast \
    --data_dir features/resnet152_${SLURM_ARRAY_TASK_ID} \
    --feature_dim 2048 \
    --train_split train_s${SLURM_ARRAY_TASK_ID}.txt \
    --test_split test_s${SLURM_ARRAY_TASK_ID}.txt \
    --batch_size 1 \
    --iterations 30000 \
    --network lstmnet \
    --dropout_chance 0.3 \
    --lr_decay 0.1 \
    --lr_decay_every 10000 \
    --log_every 100 \
    --test_every 1000 \
    --subsample \
    --indices \
    --indices_normalizer 2162 \
