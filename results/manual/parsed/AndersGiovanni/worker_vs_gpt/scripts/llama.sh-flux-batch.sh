#!/bin/bash
#FLUX: --job-name=llama
#FLUX: -c=12
#FLUX: --queue=brown,red
#FLUX: -t=14400
#FLUX: --urgency=16

hostname
nvidia-smi
python -m src.worker_vs_gpt.llm_local
