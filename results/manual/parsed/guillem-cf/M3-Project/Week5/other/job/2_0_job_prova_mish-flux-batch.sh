#!/bin/bash
#FLUX: --job-name=salted-soup-1226
#FLUX: --urgency=16

eval "$(conda shell.bash hook)"
conda activate m3
python main.py --config config/prova_mish.yaml
