#!/bin/bash
#FLUX: --job-name=chunky-plant-4879
#FLUX: -n=4
#FLUX: --queue=mhigh,mhigh
#FLUX: --urgency=16

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
