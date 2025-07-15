#!/bin/bash
#FLUX: --job-name=astute-buttface-0806
#FLUX: -c=2
#FLUX: --queue=infofil01
#FLUX: --urgency=16

nvidia-smi
CUDA_VISIBLE_DEVICES=0,1 python main.py --gpu='0 1' --batch_size=24 --model=USDA_P --data=jddc --bert_name=bert-base-chinese --pretrain_model=../pretrain/outputs/jddc_pretrain_BERT/best_pretrain.pt
