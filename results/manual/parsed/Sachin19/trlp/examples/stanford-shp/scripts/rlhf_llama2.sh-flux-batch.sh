#!/bin/bash
#FLUX: --job-name=conspicuous-avocado-5022
#FLUX: --urgency=16

module load cuda-11.1.1 cudnn-11.1.1-v8.0.4.30
module load gcc-7.4
cd /projects/tir6/general/sachink/personalized-LM/2023/trl/examples/stanford-shp
nvidia-smi
instrtype=$1
subset=$2
port=$3
torchrun --nnodes 1  --nproc_per_node 1 --rdzv_endpoint 0.0.0.0:$port scripts/rlft_llama.py\
    --data_source reddit\
    --instrtype ${instrtype}\
    --subset ${subset}\
    --log_with=wandb\
    --model_name=/projects/tir6/general/sachink/personalized-LM/2023/models/0923-newreddit/sft/llama-7B_${instrtype}_${subset}/final_checkpoint\
    --reward_model_name=/projects/tir6/general/sachink/personalized-LM/2023/models/0923/reward_models/hf_model-7B_peft_reddit_${instrtype}_${subset}_2e-05_peft_last_checkpoint\
    --adafactor=False\
    --tokenizer_name="/projects/tir6/general/sachink/personalized-LM/2023/llama/hf_model-7B"\
    --save_freq=100\
    --eval_freq=1\
    --output_max_length=128\
    --batch_size=48\
    --mini_batch_size=1\
    --gradient_accumulation_steps=48\
    --batched_gen=True\
    --ppo_epochs=4\
    --seed=0\
    --learning_rate=1.4e-5\
    --early_stopping=True\
    --output_dir=/projects/tir6/general/sachink/personalized-LM/2023/models/1023-newreddit/rlhf/llama-se-rl-finetune-128-8-8-1.4e-5_adam_${instrtype}_${subset}
