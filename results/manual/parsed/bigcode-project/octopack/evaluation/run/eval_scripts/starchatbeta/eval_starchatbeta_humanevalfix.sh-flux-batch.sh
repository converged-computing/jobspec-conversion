#!/bin/bash
#FLUX: --job-name=sticky-train-4527
#FLUX: --exclusive
#FLUX: --urgency=16

source /pfs/lustrep2/scratch/project_462000241/muennighoff/venv/bin/activate
cd /pfs/lustrep2/scratch/project_462000185/muennighoff/bigcode-evaluation-harness
accelerate launch --config_file config_1gpus_bf16.yaml --main_process_port 20888 main.py \
--model starchat-beta \
--tasks humanevalfixtests-python \
--do_sample True \
--temperature 0.2 \
--n_samples 20 \
--batch_size 5 \
--allow_code_execution \
--save_generations \
--trust_remote_code \
--prompt starchat \
--save_generations_path generations_humanevalfixpython_starchatbeta_temp02.json \
--metric_output_path evaluation_humanevalfixpython_starchatbeta_temp02.json \
--max_length_generation 2048 \
--generation_only \
--precision bf16
