#!/bin/bash
#FLUX: --job-name=mistral-7b-chat-pdf
#FLUX: --queue=spgpu
#FLUX: -t=28800
#FLUX: --priority=16

module purge
module load python3.10-anaconda
conda activate llm
cd /home/asaklani/llm-recipes/
nvidia-smi
python scripts/train.py --config models/mistral-7b-dolly-5k-rag-split/mistral-7b-dolly-rag.yml
