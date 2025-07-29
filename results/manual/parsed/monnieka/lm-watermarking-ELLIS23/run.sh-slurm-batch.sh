#!/bin/bash
#SBATCH --account=tra23_ELLIS
#SBATCH --output=out/out_%A_%j.out
#SBATCH --error=err/out_%A_%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=52GB
#SBATCH --time=01:00:00
#SBATCH --constraint=ntasks-per-node=8

export OMP_PROC_BIND='true'

job.out # for stdout redirection
module load deeplrn
module av cineca-ai
export OMP_PROC_BIND=true
python run_watermarking.py \
    --model_name facebook/opt-1.3b \
    --dataset_name c4 \
    --dataset_config_name realnewslike \
    --max_new_tokens 200 \
    --min_prompt_tokens 50 \
    --limit_indices 500 \
    --input_truncation_strategy completion_length \
    --input_filtering_strategy prompt_and_completion_length \
    --output_filtering_strategy max_new_tokens \
    --dynamic_seed markov_1 \
    --bl_proportion 0.5 \
    --bl_logit_bias 2.0 \
    --bl_type soft \
    --store_spike_ents True \
    --num_beams 1 \
    --use_sampling True \
    --sampling_temp 0.7
    --oracle_model_name facebook/opt-2.7b \
    --run_name example_run \
    --output_dir ./all_runs \
