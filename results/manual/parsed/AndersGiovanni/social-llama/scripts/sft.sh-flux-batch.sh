#!/bin/bash
#FLUX: --job-name=sft
#FLUX: -c=12
#FLUX: --queue=brown,red
#FLUX: -t=86400
#FLUX: --urgency=16

hostname
nvidia-smi
python -m src.social_llama.training.sft
