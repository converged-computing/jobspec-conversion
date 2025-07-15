#!/bin/bash
#FLUX: --job-name=chocolate-house-1934
#FLUX: --urgency=16

sbatch --wait << EOF
source $HOME/.bashrc
conda activate RL
all_args=("$@")
ds_names=("${all_args[@]:6}")
rnareplearn --gin $1 --dataset_path $2 --dataset_type UTR --train_indices $3 --val_indices $4  --output $5 --dataset_names $6 --train_mode TE --eval_model
EOF
