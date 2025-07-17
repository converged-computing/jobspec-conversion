#!/bin/bash
#FLUX: --job-name=run
#FLUX: --queue=gpu-a100-small
#FLUX: -t=600
#FLUX: --urgency=16

cd /work/07016/cw38637/ls6/nlp/
module load cuda/12.2
torchrun --nproc_per_node 1 llama3_generation.py
