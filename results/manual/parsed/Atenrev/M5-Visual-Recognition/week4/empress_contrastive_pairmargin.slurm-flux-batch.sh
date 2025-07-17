#!/bin/bash
#FLUX: --job-name=arid-lizard-8946
#FLUX: -n=4
#FLUX: --queue=mhigh,mhigh
#FLUX: --urgency=16

python task_b.py \
    --loss "contrastive" \
    --miner "PairMargin" \
	--output_path "outputs_task_b/" \
    --dataset "mit_split" \
    --dataset_config_path "./configs/mit_split.yaml" \
    --dataset_path "/home/mcv/datasets/MIT_split/" \
	--model resnet_18 \
    --embedding_size 256 \
	--batch_size 64 \
    --epochs 20
