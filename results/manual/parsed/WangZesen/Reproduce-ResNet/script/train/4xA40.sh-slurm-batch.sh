#!/bin/bash
#SBATCH --job-name=resnet
#SBATCH --output=log/%A/log.out
#SBATCH --error=log/%A/err.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=14:00:00

export LOGLEVEL='INFO'

export LOGLEVEL=INFO
mkdir -p log/$SLURM_JOB_ID
cp $2 log/$SLURM_JOB_ID/data_cfg.toml
cp $3 log/$SLURM_JOB_ID/train_cfg.toml
srun $1 \
    --standalone \
    --nproc_per_node=4 \
    --rdzv-backend=c10d \
    src/train.py --data-cfg log/$SLURM_JOB_ID/data_cfg.toml --train-cfg log/$SLURM_JOB_ID/train_cfg.toml
