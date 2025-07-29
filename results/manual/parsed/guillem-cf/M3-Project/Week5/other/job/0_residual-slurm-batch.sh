#!/bin/bash
#FLUX: --job-name=peachy-leader-2030
#FLUX: -n=4
#FLUX: --queue=mhigh,mhigh
#FLUX: --urgency=16

eval "$(conda shell.bash hook)"
conda activate m3
python main.py --config config/prova_residual.yaml
