#!/bin/bash
#FLUX: --job-name=chocolate-egg-3065
#FLUX: --priority=16

python task_b.py \
    --loss "triplet"  \
    --miner "TripletMargin" \
	--output_path "outputs_task_c/" \
    --dataset "mit_split" \
    --dataset_config_path "./configs/mit_split.yaml" \
    --dataset_path "/home/mcv/datasets/MIT_split/" \
	--model resnet_18 \
    --embedding_size 256 \
	--batch_size 64 \
    --epochs 20
