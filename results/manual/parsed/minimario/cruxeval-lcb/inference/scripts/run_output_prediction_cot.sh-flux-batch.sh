#!/bin/bash
#FLUX: --job-name=fuzzy-despacito-4185
#FLUX: -c=10
#FLUX: --gpus-per-task=1
#FLUX: --queue=learnlab
#FLUX: -t=10800
#FLUX: --urgency=16

dirs=(
    # "codellama-7b"
    # "codellama-13b"
    # "codellama-34b"
    # "codellama-python-7b"
    # "codellama-python-13b"
    # "codellama-python-34b"
    "codetulu-2-34b"
    "deepseek-base-1.3b"
    "deepseek-base-6.7b"
    "deepseek-base-33b"
    # "deepseek-instruct-1.3b"
    # "deepseek-instruct-6.7b"
    # "deepseek-instruct-33b"
    # "magicoder-ds-7b"
    # "mistral-7b"
    # "phi-1"
    # "phi-1.5"
    # "phi-2"
    # "phind"
    # "starcoderbase-7b"
    # "starcoderbase-16b"
    # "wizard-13b"
    # "wizard-34b"
)
models=(
    # "codellama/CodeLlama-7b-hf"
    # "codellama/CodeLlama-13b-hf"
    # "codellama/CodeLlama-34b-hf"
    # "codellama/CodeLlama-7b-Python-hf"
    # "codellama/CodeLlama-13b-Python-hf"
    # "codellama/CodeLlama-34b-Python-hf"
    "allenai/codetulu-2-34b"
    "deepseek-ai/deepseek-coder-1.3b-base"
    "deepseek-ai/deepseek-coder-6.7b-base"
    "deepseek-ai/deepseek-coder-33b-base"
    # "deepseek-ai/deepseek-coder-1.3b-instruct"
    # "deepseek-ai/deepseek-coder-6.7b-instruct"
    # "deepseek-ai/deepseek-coder-33b-instruct"
    # "ise-uiuc/Magicoder-S-DS-6.7B"
    # "mistralai/Mistral-7B-v0.1"
    # "microsoft/phi-1"
    # "microsoft/phi-1_5"
    # "microsoft/phi-2"
    # "Phind/Phind-CodeLlama-34B-v2"
    # "bigcode/starcoderbase-7b"
    # "bigcode/starcoderbase"
    # "WizardLM/WizardCoder-Python-13B-V1.0"
    # "WizardLM/WizardCoder-Python-34B-V1.0"
)
temperatures=(0.2)
for ((i=0; i<${#models[@]}; i++)); do
    model=${models[$i]}
    base_dir=${dirs[$i]}
    echo $model
    for temperature in "${temperatures[@]}"; do
        dir="${base_dir}+cot_temp${temperature}_output"
        cat <<EOF > temp_sbatch_script.sh
dir=$dir
SIZE=479
GPUS=10
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
    --tasks output_prediction \
    --batch_size 5 \
    --n_samples 10 \
    --max_length_generation 2048 \
    --precision bf16 \
    --limit \$SIZE \
    --temperature $temperature \
    --save_generations \
    --save_generations_path model_generations_raw/\${dir}/shard_\$((\$i)).json \
    --start \$((\$i*SIZE/GPUS)) \
    --end \$((\$ip*SIZE/GPUS)) \
    --cot \
    --shuffle
EOF
        sbatch temp_sbatch_script.sh
        rm temp_sbatch_script.sh
    done
done
