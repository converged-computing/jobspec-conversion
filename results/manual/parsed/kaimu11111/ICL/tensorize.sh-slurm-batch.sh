#!/bin/bash
#SBATCH --job-name=icl
#SBATCH --output=log/%j.out
#SBATCH --error=log/%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:a100:1
#SBATCH --mem=62gb
#SBATCH --time=2-00:00:00

METHOD=channel
N_PREFIX=10
TASK=tune
SPLIT=train
CUDA_VISIBLE_DEVICES=5 python train.py\
  --task $TASK\
  --split $SPLIT\
  --tensorize_dir tensorized\
  --seed 100\
  --method $METHOD\
  --n_prefix_tokens $N_PREFIX\
  --do_tensorize\
  --n_gpu 1\
  --n_process 10\
