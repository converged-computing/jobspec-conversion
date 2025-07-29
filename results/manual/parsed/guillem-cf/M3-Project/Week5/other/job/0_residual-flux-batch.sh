#!/bin/bash
#FLUX --job-name=frigid-house-0050
#FLUX -n=4
#FLUX --queue=mhigh,mhigh
#FLUX --urgency=16

eval "$(conda shell.bash hook)"
conda activate m3
python main.py --config config/prova_residual.yaml
