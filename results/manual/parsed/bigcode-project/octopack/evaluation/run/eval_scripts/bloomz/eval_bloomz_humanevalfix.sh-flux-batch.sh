#!/bin/bash
#FLUX: --job-name=lovely-leader-2198
#FLUX: --exclusive
#FLUX: --priority=16

source $ajs_ALL_CCFRWORK/start-tr13f-6B3-ml-t0
conda activate bigcode
cd /gpfswork/rech/ajs/commun/code/bigcode/bigcode-evaluation-harness
accelerate launch --config_file config_8gpus_bf16.yaml main.py \
--model bloomz \
--tasks humanevalfixtests-python \
--do_sample True \
--temperature 0.2 \
--n_samples 20 \
--batch_size 2 \
--allow_code_execution \
--save_generations \
--trust_remote_code \
--prompt instruct \
--save_generations_path generations_humanevalfixpython_bloomz.json \
--metric_output_path evaluation_humanevalfixpython_bloomz.json \
--max_length_generation 2048 \
--precision bf16 \
--max_memory_per_gpu 50GB
