#!/bin/bash
#FLUX: --job-name=goodbye-punk-3219
#FLUX: --queue=amd_gpu
#FLUX: -t=450000
#FLUX: --urgency=16

ml GCCcore/11.3.0 Python/3.10.4
source venv/bin/activate
python train.py configs/llama2_7b_chat_uncensored_original.yaml
