#!/bin/bash
#FLUX: --job-name=arid-car-3397
#FLUX: -n=4
#FLUX: --queue=mhigh,mhigh
#FLUX: --urgency=16

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
