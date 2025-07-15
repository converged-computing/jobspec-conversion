#!/bin/bash
#FLUX: --job-name=eval
#FLUX: -c=8
#FLUX: -t=72000
#FLUX: --urgency=16

source $ajs_ALL_CCFRWORK/start-tr13f-6B3-ml-t0
conda activate bigcode
cd /gpfswork/rech/ajs/commun/code/bigcode/bigcode-evaluation-harness
accelerate launch --config_file config_1a100_fp16.yaml main.py \
--model instructcodet5p-16b \
--tasks humanevalfixtests-python \
--do_sample True \
--temperature 0.2 \
--n_samples 20 \
--batch_size 5 \
--allow_code_execution \
--save_generations \
--trust_remote_code \
--prompt instructcodet5p \
--save_generations_path generations_humanevalfixpython_instructcodet5p.json \
--metric_output_path evaluation_humanevalfixpython_instructcodet5p.json \
--modeltype seq2seq \
--max_length_generation 2048 \
--precision fp16
