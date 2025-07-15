#!/bin/bash
#FLUX: --job-name=pusheena-eagle-6236
#FLUX: -t=450000
#FLUX: --urgency=16

ml GCCcore/11.3.0 Python/3.10.4
source venv/bin/activate
python train.py configs/llama2_7b_chat_uncensored_original.yaml
