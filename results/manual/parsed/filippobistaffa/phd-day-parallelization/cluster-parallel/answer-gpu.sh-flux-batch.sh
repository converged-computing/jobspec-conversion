#!/bin/bash
#FLUX: --job-name=llama-cpp-answer-gpu
#FLUX: -c=20
#FLUX: --queue=gpu
#FLUX: -t=600
#FLUX: --priority=16

spack load cuda@11.8.0
LLAMA_CPP_HOME="/home/filippo.bistaffa/phd-day-parallelization/cluster-parallel/llama.cpp"
MODEL="${LLAMA_CPP_HOME}/models/vicuna-13b-v1.5-16k.Q4_K_M.gguf"
PROMPT="The Answer to the Ultimate Question of Life, the Universe, and Everything is"
${LLAMA_CPP_HOME}/build/bin/main --model ${MODEL} --prompt "${PROMPT}" --escape --log-disable --repeat_penalty 1.1 --ctx-size 4096 --n-predict -1 --temp 0.7 --seed 0 --n-gpu-layers 40
