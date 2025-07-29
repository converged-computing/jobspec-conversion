#!/bin/bash
#SBATCH --job-name=spbr7
#SBATCH --output=/iliad/u/minae/reward_adaptation/jobs/%x.o
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --gres=gpu:1
#SBATCH --mem=4G
#SBATCH --partition=iliad
#SBATCH --qos=normal

CUDA_VISIBLE_DEVICES=0 python train.py --env nav1_sparse --bs 7 --experiment_dir output/sparse --expt_type ours
echo "done"
