#!/bin/bash
#SBATCH --job-name=lm_eval_falcon-40b_mgsm-mt
#SBATCH --output=../.slurm/lm_eval_falcon-40b_mgsm-mt.out
#SBATCH --error=../.slurm/lm_eval_falcon-40b_mgsm-mt.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --gres=gpu:2
#SBATCH --mem=50GB
#SBATCH --constraint=ntasks-per-node=1

export TRANSFORMERS_CACHE='/gaueko0/transformers_cache/'
export TOKENIZERS_PARALLELISM='false'

source /gaueko0/users/jetxaniz007/phd/venv2/bin/activate
export TRANSFORMERS_CACHE="/gaueko0/transformers_cache/"
export TOKENIZERS_PARALLELISM=false
model_names=(
    "tiiuae/falcon-40b"
)
source ../tasks.sh
tasks_selected=(
    "mgsm-mt"
)
num_fewshot=8
for model_name in "${model_names[@]}"; do
    for group_name in "${tasks_selected[@]}"; do
        srun python3 ../../lm-evaluation-harness/main.py \
            --model hf-causal-experimental \
            --model_args pretrained=$model_name,use_accelerate=True,trust_remote_code=True,dtype=bfloat16 \
            --tasks ${tasks[${group_name}]} \
            --device cuda \
            --output_path ../../results/falcon/${model_name:7}/${model_name:7}_${group_name}_${num_fewshot}-shot.json \
            --batch_size 6 \
            --no_cache \
            --num_fewshot ${num_fewshot}
    done
done
