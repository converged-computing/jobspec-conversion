#!/bin/bash
#SBATCH --output=logs/%x_%u_%j.out
#SBATCH --error=logs/%x_%u_%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem-per-cpu=4096

python task_b.py \
    --loss "triplet"  \
    --miner "BatchHard" \
	--output_path "outputs_task_c/" \
    --dataset "mit_split" \
    --dataset_config_path "./configs/mit_split.yaml" \
    --dataset_path "/home/mcv/datasets/MIT_split/" \
	--model resnet_18 \
    --embedding_size 256 \
	--batch_size 64 \
    --epochs 20
