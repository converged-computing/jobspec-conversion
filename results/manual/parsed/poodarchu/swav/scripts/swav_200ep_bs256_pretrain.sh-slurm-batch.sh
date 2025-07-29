#!/bin/bash
#SBATCH --job-name=swav_200ep_bs256_pretrain
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --gres=4
#SBATCH --mem=150G
#SBATCH --time=3-00:00:00
#SBATCH --constraint=ntasks-per-node=4

DATASET_PATH="/data/Datasets/ILSVRC2012/train"
EXPERIMENT_PATH="./experiments/swav_200ep_bs256_pretrain"
mkdir -p $EXPERIMENT_PATH
python -m torch.distributed.launch --nproc_per_node=8  main_swav.py \
--data_path $DATASET_PATH \
--nmb_crops 2 6 \
--size_crops 224 96 \
--min_scale_crops 0.14 0.05 \
--max_scale_crops 1. 0.14 \
--crops_for_assign 0 1 \
--use_pil_blur true \
--temperature 0.1 \
--epsilon 0.05 \
--sinkhorn_iterations 3 \
--feat_dim 128 \
--nmb_prototypes 3000 \
--queue_length 3840 \
--epoch_queue_starts 15 \
--epochs 200 \
--batch_size 32 \
--base_lr 0.6 \
--final_lr 0.0006 \
--freeze_prototypes_niters 5005 \
--wd 0.000001 \
--warmup_epochs 0 \
--arch resnet50 \
--use_fp16 false \
--sync_bn pytorch \
--dump_path $EXPERIMENT_PATH \
