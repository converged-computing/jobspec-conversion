#!/bin/bash
#FLUX: --job-name=pusheena-frito-2409
#FLUX: --urgency=16

eval "$(conda shell.bash hook)"
conda activate m3
python main.py --config config/best_model.yaml
