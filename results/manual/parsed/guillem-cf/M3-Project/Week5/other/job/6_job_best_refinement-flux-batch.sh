#!/bin/bash
#FLUX: --job-name=crunchy-peas-4511
#FLUX: --priority=16

eval "$(conda shell.bash hook)"
conda activate m3
python main.py --config config/best_model.yaml
