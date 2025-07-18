#!/bin/bash
#FLUX: --job-name=tart-parsnip-4371
#FLUX: -c=10
#FLUX: --queue=tenenbaum
#FLUX: -t=10800
#FLUX: --urgency=16

dirs=(
    # "codellama-7b"
    # "codellama-13b"
    # "codellama-34b"
    # "codellama-python-7b"
    # "codellama-python-13b"
    # "codellama-python-34b"
    # "codetulu-2-34b"
    # "deepseek-base-1.3b"
    # "deepseek-base-6.7b"
    "deepseek-base-33b"
    # "deepseek-instruct-1.3b"
    # "deepseek-instruct-6.7b"
    "deepseek-instruct-33b"
    # "magicoder-ds-7b"
    # "mistral-7b"
    # "mixtral-8x7b"
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
    # "allenai/codetulu-2-34b"
    # "deepseek-ai/deepseek-coder-1.3b-base"
    # "deepseek-ai/deepseek-coder-6.7b-base"
    "deepseek-ai/deepseek-coder-33b-base"
    # "deepseek-ai/deepseek-coder-1.3b-instruct"
    # "deepseek-ai/deepseek-coder-6.7b-instruct"
    "deepseek-ai/deepseek-coder-33b-instruct"
    # "ise-uiuc/Magicoder-S-DS-6.7B"
    # "mistralai/Mistral-7B-v0.1"
    # "mistralai/Mixtral-8x7B-v0.1"
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
        dir="${base_dir}_temp${temperature}_verify"
        cat <<EOF > temp_sbatch_script.sh
source ~/.bashrc
conda activate cruxeval
module load openmind8/cuda/11.7
cd /om2/user/gua/Documents/verify/inference
dir=$dir
SIZE=690
GPUS=4
i=\$SLURM_ARRAY_TASK_ID
ip=\$((\$i+1))
echo \$dir
mkdir -p model_generations_raw/\$dir
string="Starting iteration \$i with start and end  \$((i*SIZE/GPUS)) \$((ip*SIZE/GPUS))"
echo \$string
python main.py \
    --model $model \
    --use_auth_token \
    --trust_remote_code \
    --tasks code_verification \
    --batch_size 5 \
    --n_samples 5 \
    --max_length_generation 1024 \
    --precision bf16 \
    --limit \$SIZE \
    --temperature $temperature \
    --save_generations \
    --save_generations_path model_generations_raw/\${dir}/shard_\$((\$i)).json \
    --start \$((i*SIZE/GPUS)) \
    --end \$((ip*SIZE/GPUS)) \
    --shuffle \
    --tensor_parallel_size 1
EOF
        sbatch temp_sbatch_script.sh
        rm temp_sbatch_script.sh
    done
done
