#!/bin/bash
#FLUX: --job-name=eval
#FLUX: -c=8
#FLUX: -t=72000
#FLUX: --urgency=16

source $ajs_ALL_CCFRWORK/start-tr13f-6B3-ml-t0
conda activate bigcode
cd /gpfswork/rech/ajs/commun/code/bigcode/bigcode-evaluation-harness
accelerate launch --config_file config_1a100_fp16.yaml main.py \
--model diff-codegen-2b-v2 \
--tasks humanevalfixtests-python \
--do_sample True \
--temperature 0.2 \
--n_samples 20 \
--batch_size 20 \
--allow_code_execution \
--save_generations \
--trust_remote_code \
--prompt diff-carper \
--save_generations_path generations_humanevalfixpython_diffcodegen2b.json \
--metric_output_path evaluation_humanevalfixpython_diffcodegen2b.json \
--max_length_generation 1024 \
--precision fp16
