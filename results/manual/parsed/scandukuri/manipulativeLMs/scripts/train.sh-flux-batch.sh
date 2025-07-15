#!/bin/bash
#FLUX: --job-name=doopy-buttface-9969
#FLUX: -c=48
#FLUX: --queue=cocoflops
#FLUX: -t=172800
#FLUX: --priority=16

source /scr/jphilipp/miniconda3/etc/profile.d/conda.sh
conda activate py310-jphilipp 
wandb login --relogin 0242cef7ea759b3e7b2ff2fab0b7ddf5997f57f8 # i'd recommend doing this through an env variable prior to submitting the job or smth that is looked for in your training script.py
cd ~/research_projects/social_tuning/manipulativeLMs/training
torchrun --standalone \
    --nproc_per_node=2 ~/research_projects/social_tuning/manipulativeLMs/training/train.py \
    --node_dir '/scr/jphilipp/manipulativeLM-nodecontents/' \
    --pretrained_models_subdir 'pretrained_models/' \
    --output_models_subdir 'output_models/' \
    --rawdata_subdir 'rawdata/normbank/normbank.csv' \
    --processeddata_subdir 'processeddata/' \
    --model_checkpoint 'alpaca_7b' --tokenizer_checkpoint '7B' --architecture 'causal-lm' \
    --model_output 'alpaca_7b_normbankFT' \
    --save_total_limit 10 --save_steps 1000 \
    --microbatchsize 8
