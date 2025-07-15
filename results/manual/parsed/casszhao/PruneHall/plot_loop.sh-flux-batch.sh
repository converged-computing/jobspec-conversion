#!/bin/bash
#FLUX: --job-name=ab
#FLUX: --queue=gpu
#FLUX: -t=43200
#FLUX: --urgency=16

module load Anaconda3/2022.10
module load CUDA/11.8.0
source activate seq
model_handle="Mistral-7B-Instruct-v0.1_"
dataset="factcc"
for prompt in "A" "B" "C"
do
for ratio in "0.1" "0.2" "0.3" "0.4" "0.5" "0.6" "0.7"
do 
model_name=$model_handle$ratio
for method in "wanda" "sparsegpt" "fullmodel" "magnitude"
do
python save_attention_and_plot.py --prompt_id $prompt --prune_method $method --model $model_name --data $dataset
done
done
done
