#!/bin/bash
#FLUX: --job-name=t11_wb
#FLUX: -t=86400
#FLUX: --urgency=16

module load cuda/11.2
python3 wandb-tune.py
