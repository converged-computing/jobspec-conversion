#!/bin/bash
#FLUX: --job-name=llama-cpp-description-mixtral-gpu
#FLUX: -c=20
#FLUX: --queue=gpu
#FLUX: -t=600
#FLUX: --urgency=16

spack load cuda@11.8.0
spack load --first py-pandas
python3 description.py --model "llama.cpp/models/mixtral-8x7b-instruct-v0.1.Q4_K_M.gguf" --format "[INST] {} [/INST]" --seed $RANDOM --n-gpu-layers 12
