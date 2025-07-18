#!/bin/bash
#FLUX: --job-name=angry-staircase-0999
#FLUX: --exclusive
#FLUX: --urgency=16

CUDA_VISIBLE_DEVICES=0,1 python main.py \
						 --model resnet50 \
						 --temperature 0.5 \
						 --epochs 400 \
						 --batch-size 256 \
						 --weight 0.03 \
						 --equiv-splits 16 \
						 --dataset-name cifar10 \
						 --log-freq 1 \
						 --save-root ./results \
						 --data-root ./data \
						 --project project_name \
						 --user sample_user \
						 --run-name test \
wait
echo "Run completed at:- "
date
