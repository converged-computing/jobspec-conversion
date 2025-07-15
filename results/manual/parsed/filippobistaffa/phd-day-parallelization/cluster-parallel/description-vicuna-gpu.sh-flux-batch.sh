#!/bin/bash
#FLUX: --job-name=llama-cpp-description-vicuna-gpu
#FLUX: -c=32
#FLUX: --queue=gpu
#FLUX: -t=600
#FLUX: --priority=16

spack load cuda@11.8.0
spack load --first py-pandas
srun python3 description.py --seed $RANDOM --n-gpu-layers 32
