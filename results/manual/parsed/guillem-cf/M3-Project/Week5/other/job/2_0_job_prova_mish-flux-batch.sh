#!/bin/bash
#FLUX: --job-name=moolicious-peanut-4773
#FLUX: -n=4
#FLUX: --queue=mhigh,mhigh
#FLUX: --urgency=16

eval "$(conda shell.bash hook)"
conda activate m3
python main.py --config config/prova_mish.yaml
