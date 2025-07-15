#!/bin/bash
#FLUX: --job-name=llama-cpp-description-mixtral
#FLUX: -c=20
#FLUX: -t=600
#FLUX: --priority=16

spack load --first py-pandas
python3 description.py --model "llama.cpp/models/mixtral-8x7b-instruct-v0.1.Q4_K_M.gguf" --format "[INST] {} [/INST]" --seed $RANDOM
