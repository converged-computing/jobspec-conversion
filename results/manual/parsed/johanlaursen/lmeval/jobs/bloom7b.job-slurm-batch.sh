#!/bin/bash
#SBATCH --job-name=lmeval_bloom7B
#SBATCH --account=researchers
#SBATCH --output=../logs/R-%x.%j.out
#SBATCH --error=../logs/R-%x.%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --gres=gpu:1
#SBATCH --mem=48G
#SBATCH --time=02:00:00
#SBATCH --partition=red,brown
#SBATCH --constraint=gpu_rtx8000|gpu_a100_40gb|gpu_v100

source activate lmeval # Not working???
nvidia-smi
model_path="bigscience/bloom-7b1"
model_name="bloom-7b1"
echo $model_name
lm_eval --model hf --model_args "pretrained=$model_path" --tasks "know_dist" --batch_size auto --max_batch_size 64 --device cuda:0 --output_path "../results/$model_name" --num_fewshot 0
