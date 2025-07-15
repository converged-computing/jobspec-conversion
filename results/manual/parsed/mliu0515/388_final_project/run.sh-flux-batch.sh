#!/bin/bash
#FLUX: --job-name=astute-snack-7725
#FLUX: --urgency=16

cd /work/07016/cw38637/ls6/nlp/
module load cuda/12.2
torchrun --nproc_per_node 1 llama3_generation.py
