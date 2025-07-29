#!/bin/bash
#SBATCH --job-name=LrgSklCNN
#SBATCH --output=/groups/cherkasvgrp/share/progressive_docking/hmslati/plif_cnn/%x-%j.out
#SBATCH --nodes=2
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=10
#SBATCH --gres=gpu:1
#SBATCH --mem=0
#SBATCH --constraint=ntasks-per-node=1
#SBATCH --chdir=/groups/cherkasvgrp/share/progressive_docking/hmslati/plif_cnn/

export MASTER_PORT='12349'
export WORLD_SIZE='2'
export MASTER_ADDR='$master_addr'

module purge
module load pytorch-gpu/py3/1.5.0
export MASTER_PORT=12349
export WORLD_SIZE=2
echo "NODELIST="${SLURM_NODELIST}
master_addr=$(scontrol show hostnames "$SLURM_JOB_NODELIST" | head -n 1)
export MASTER_ADDR=$master_addr
echo "MASTER_ADDR="$MASTER_ADDR
source ~/.bashrc
conda activate plifs
srun python -u trial_main_final.py --net cnn
