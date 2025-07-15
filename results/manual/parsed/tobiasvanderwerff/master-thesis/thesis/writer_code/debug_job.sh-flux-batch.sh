#!/bin/bash
#FLUX: --job-name='dbg'
#FLUX: --queue=gpushort
#FLUX: -t=600
#FLUX: --priority=16

set -euo pipefail
module purge
module load Python/3.8.6-GCCcore-10.2.0
source ~/activate_py3.8.6
seed=$SLURM_ARRAY_TASK_ID
main_model_arch="WriterCodeAdaptiveModel"
base_model_arch="fphtr"
learning_rate=1e-5
weight_decay=0
shots=4
ways=4
TRAINED_MODEL_PATH=/data/s4314719/full_page_HTR/lightning_logs/FPHTR_word_resnet18_lr=3e-4_bsz=32_seed=3/checkpoints/epoch=64-char_error_rate=0.1500-word_error_rate=0.1738.ckpt
CACHE_DIR=/data/s4314719/thesis/writer_code/lightning_logs/cache_without_bad_segmentation
srun python main.py \
--main_model_arch $main_model_arch \
--base_model_arch $base_model_arch \
--trained_model_path $TRAINED_MODEL_PATH \
--cache_dir $CACHE_DIR \
--learning_rate $learning_rate \
--weight_decay $weight_decay \
--seed $seed \
--shots $shots \
--ways $ways \
--data_dir /data/s4314719/IAM \
--max_epochs 1000 \
--num_workers 12 \
--track_grad_norm 2 \
--check_val_every_n_epoch 10000 \
--num_sanity_val_steps 0 \
