#!/bin/bash
#SBATCH --job-name=ChomGPT
#SBATCH --account=scads
#SBATCH --output=log/task.out.%j
#SBATCH --error=log/task.out.%j
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --gres=1
#SBATCH --mem=16GB
#SBATCH --time=3-00:00:00

cd /ist/users/patompornp/wangchanx/ChomGPT/script
conda activate chat
nvidia-smi
python3 -c "import torch;print('# gpus: %d'%torch.cuda.device_count())"
python train_sft.py \
    --model_name=/ist/users/patompornp/models/facebook/xglm-7.5B \
    --dataset_name=/ist/users/patompornp/datasets/pythainlp/alpaca_en_sft \
    --per_device_train_batch_size=8 \
    --per_device_eval_batch_size=8 \
    --gradient_accumulation_steps=16 \
    --model_name=facebook/xglm-7.5B \
    --bf16 \
    --deepspeed=../config/sft_deepspeed_config.json \
    --is_logging 0
python -m torch.distributed.launch --nproc_per_node=1 train_sft.py \
    --model_name=/ist/users/patompornp/models/facebook/xglm-7.5B \
    --dataset_name=/ist/users/patompornp/datasets/pythainlp/alpaca_en_sft \
    --per_device_train_batch_size=8 \
    --per_device_eval_batch_size=8 \
    --gradient_accumulation_steps=16 \
    --model_name=facebook/xglm-7.5B \
    --bf16 \
    --deepspeed=../config/sft_deepspeed_config.json \
    --is_logging 0
