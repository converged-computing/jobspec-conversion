#!/bin/bash
#FLUX: --job-name=ornery-malarkey-4656
#FLUX: -c=10
#FLUX: --gpus-per-task=2
#FLUX: --queue=learnlab
#FLUX: -t=10800
#FLUX: --priority=16

dirs=(
    # "codellama/CodeLlama-7b-hf"
    # "codellama/CodeLlama-13b-hf"
    # "codellama/CodeLlama-34b-hf"
    # "deepseek-ai/deepseek-coder-1.3b-base"
    # "deepseek-ai/deepseek-coder-6.7b-base"
    # "deepseek-ai/deepseek-coder-33b-base"
    # "deepseek-ai/deepseek-coder-1.3b-instruct"
    # "deepseek-ai/deepseek-coder-6.7b-instruct"
    # "deepseek-ai/deepseek-coder-33b-instruct"
    # "ise-uiuc/Magicoder-S-DS-6.7B"
    # "ise-uiuc/Magicoder-S-CL-7B"
    # "mistralai/Mistral-7B-v0.1"
    "mixtral-8x7b"
)
models=(
    # "codellama/CodeLlama-7b-hf"
    # "codellama/CodeLlama-13b-hf"
    # "codellama/CodeLlama-34b-hf"
    # "deepseek-ai/deepseek-coder-1.3b-base"
    # "deepseek-ai/deepseek-coder-6.7b-base"
    # "deepseek-ai/deepseek-coder-33b-base"
    # "deepseek-ai/deepseek-coder-1.3b-instruct"
    # "deepseek-ai/deepseek-coder-6.7b-instruct"
    # "deepseek-ai/deepseek-coder-33b-instruct"
    # "ise-uiuc/Magicoder-S-DS-6.7B"
    # "ise-uiuc/Magicoder-S-CL-7B"
    # "mistralai/Mistral-7B-v0.1"
    "mistralai/Mixtral-8x7B-v0.1"
    # "bigcode/starcoder"
    # "WizardLM/WizardCoder-Python-13B-V1.0"
    # "WizardLM/WizardCoder-Python-34B-V1.0"
)
temperatures=(0.2)
for ((i=0; i<${#models[@]}; i++)); do
    model=${models[$i]}
    base_dir=${dirs[$i]}
    echo $model
    for temperature in "${temperatures[@]}"; do
        dir="${base_dir}_temp${temperature}_input"
        cat <<EOF > temp_sbatch_script.sh
dir=$dir
SIZE=479
GPUS=4
i=\$SLURM_ARRAY_TASK_ID
ip=\$((\$i+1))
echo \$dir
mkdir -p model_generations_raw/\$dir
string="Starting iteration \$i with start and end  \$((\$i*SIZE/GPUS)) \$((\$ip*SIZE/GPUS))"
echo \$string
python main.py \
    --model $model \
    --use_auth_token \
    --trust_remote_code \
    --tasks input_prediction \
    --batch_size 10 \
    --n_samples 10 \
    --max_length_generation 1024 \
    --precision bf16 \
    --limit \$SIZE \
    --temperature $temperature \
    --save_generations \
    --save_generations_path model_generations_raw/\${dir}/shard_\$((\$i)).json \
    --start \$((\$i*SIZE/GPUS)) \
    --end \$((\$ip*SIZE/GPUS)) \
    --shuffle
EOF
        sbatch temp_sbatch_script.sh
        rm temp_sbatch_script.sh
    done
done
