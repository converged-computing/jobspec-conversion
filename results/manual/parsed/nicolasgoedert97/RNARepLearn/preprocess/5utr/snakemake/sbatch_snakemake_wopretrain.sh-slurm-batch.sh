#!/bin/bash
#SBATCH --job-name=UTR
#SBATCH --account=hai_rnareplearn
#SBATCH --output=logs/%j.job
#SBATCH --error=logs/%j.job
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=03:00:00

sbatch --wait << EOF
source $HOME/.bashrc
conda activate RL
all_args=("$@")
ds_names=("${all_args[@]:6}")
rnareplearn --gin $1 --dataset_path $2 --dataset_type UTR --train_indices $3 --val_indices $4  --output $5 --dataset_names $6 --train_mode TE --eval_model
EOF
