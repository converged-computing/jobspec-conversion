#!/bin/bash
#FLUX: --job-name="emgrep-cv"
#FLUX: -c=20
#FLUX: -t=18000
#FLUX: --priority=16

module load gcc/8.2.0 python_gpu/3.10.4 eth_proxy
pip install -q -r requirements.txt
python main.py \
    --data /cluster/scratch/${USER}/nina_db/data/01_raw \
    --log_dir /cluster/scratch/${USER}/nina_db/logs \
    --debug \
    --wandb \
    --device cuda \
    --lr_cpc 2e-4 \
    --encoder_dim 512 \
    --ar_layers 5 \
    --ar_dim 512 \
    --positive_mode none \
    --split_mode subject \
    --val_idx ${SLURM_ARRAY_TASK_ID} \
    --test_idx $((SLURM_ARRAY_TASK_ID % 5 + 1)) 
