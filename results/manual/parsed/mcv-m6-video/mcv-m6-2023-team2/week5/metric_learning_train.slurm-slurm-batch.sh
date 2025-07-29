#!/bin/bash
#SBATCH --output=logs/%x_%u_%j.out
#SBATCH --error=logs/%x_%u_%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem-per-cpu=4096
#SBATCH --partition=mhigh,mhigh

python train_metric_learning.py \
    --loss "triplet"  \
    --miner "TripletMargin" \
	--output_path "outputs_metric_learning/" \
    --dataset "aic19" \
    --dataset_path "./metric_learning_dataset/" \
	--model resnet_18 \
    --embedding_size 256 \
	--batch_size 64 \
    --epochs 20
