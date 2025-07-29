#!/bin/bash
#FLUX: --job-name=dpo
#FLUX: -c=12
#FLUX: --queue=brown,red
#FLUX: -t=259200
#FLUX: --urgency=16

hostname
nvidia-smi
python -m src.social_llama.training.dpo
