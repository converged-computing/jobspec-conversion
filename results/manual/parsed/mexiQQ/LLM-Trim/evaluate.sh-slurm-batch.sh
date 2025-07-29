#!/bin/bash
#SBATCH --job-name=llm_evaluation
#SBATCH --output=job_logs/eval_logs_%j.out
#SBATCH --error=job_logs/eval_logs_%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --exclusive
#SBATCH --nodelist=c32

export PYTHONPATH='.'

cd /home/jli265/projects/LLM-Pruner
source ~/.bashrc
conda activate llm_pruner
export PYTHONPATH='.'
run_evaluation() {
    local gpu_id="$1"
    local ckpt="$2"
    local task="$3"
    local evaluation_id="$4"
    CUDA_VISIBLE_DEVICES=$gpu_id python lm-evaluation-harness/main.py \
        --model hf-causal-experimental \
        --model_args checkpoint=/mnt/beegfs/jli265/output/llm_pruner/$ckpt,config_pretrained=baffo32/decapoda-research-llama-7B-hf \
        --tasks $task \
        --device cuda:0 --no_cache \
        --batch_size 4 \
        --output_path ./evaluation_logs/eval_$evaluation_id.json >> ./evaluation_logs/eval_$evaluation_id.log 2>&1 &
}
run_evaluation_peft() {
    local gpu_id="$1"
    local ckpt="$2"
    local peft="$3"
    local task="$4"
    local evaluation_id="$5"
    CUDA_VISIBLE_DEVICES=$gpu_id python lm-evaluation-harness/main.py \
        --model hf-causal-experimental \
        --model_args checkpoint=/mnt/beegfs/jli265/output/llm_pruner/$ckpt,peft=/mnt/beegfs/jli265/output/llm_pruner/$peft,config_pretrained=baffo32/decapoda-research-llama-7B-hf \
        --tasks $task \
        --device cuda:0 --no_cache \
        --batch_size 4 \
        --output_path ./evaluation_logs/eval_$evaluation_id.json >> ./evaluation_logs/eval_$evaluation_id.log 2>&1 &
}
wait
run_evaluation 0 c33/wanda_sp/pytorch_model.bin piqa 78 
