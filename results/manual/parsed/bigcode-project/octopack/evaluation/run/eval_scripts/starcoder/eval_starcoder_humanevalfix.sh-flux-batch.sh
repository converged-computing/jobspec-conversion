#!/bin/bash
#FLUX: --job-name=evasive-itch-2433
#FLUX: -c=8
#FLUX: --exclusive
#FLUX: --priority=16

source /pfs/lustrep2/scratch/project_462000241/muennighoff/venv/bin/activate
cd /pfs/lustrep2/scratch/project_462000185/muennighoff/bigcode-evaluation-harness
accelerate launch --config_file config_1gpus_bf16.yaml --main_process_port 25900 main.py \
--model starcoder \
--tasks humanevalfixtests-python \
--do_sample True \
--temperature 0.2 \
--n_samples 20 \
--batch_size 5 \
--allow_code_execution \
--save_generations \
--trust_remote_code \
--prompt instruct \
--save_generations_path generations_humanevalfixpython_starcoder.json \
--metric_output_path evaluation_humanevalfixpython_starcoder.json \
--max_length_generation 1800 \
--precision bf16
