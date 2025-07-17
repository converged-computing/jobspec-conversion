#!/bin/bash
#FLUX: --job-name=lmeval_bloom7B
#FLUX: -c=8
#FLUX: --queue=red,brown
#FLUX: -t=7200
#FLUX: --urgency=16

source activate lmeval # Not working???
nvidia-smi
model_path="bigscience/bloom-7b1"
model_name="bloom-7b1"
echo $model_name
lm_eval --model hf --model_args "pretrained=$model_path" --tasks "know_dist" --batch_size auto --max_batch_size 64 --device cuda:0 --output_path "../results/$model_name" --num_fewshot 0
