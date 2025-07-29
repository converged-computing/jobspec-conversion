#!/bin/bash
#SBATCH --job-name=dav_nav
#SBATCH --output=data/logs/%j.out
#SBATCH --error=data/logs/%j.err
#SBATCH --nodes=16
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=10
#SBATCH --gres=gpu:2
#SBATCH --mem=250GB
#SBATCH --time=3-00:00:00
#SBATCH --partition=learnlab,learnfair
#SBATCH --constraint=ntasks-per-node=2,volta32gb

export MASTER_ADDR='$(srun --ntasks=1 hostname 2>&1 | tail -n1)'

export MASTER_ADDR=$(srun --ntasks=1 hostname 2>&1 | tail -n1)
set -x
srun python -u -m ss_baselines.av_nav.run \
    --exp-config ss_baselines/av_nav/config/audionav/mp3d/train_telephone/audiogoal_depth_ddppo.yaml  \
    --model-dir data/models/ss2/mp3d/dav_nav CONTINUOUS True
