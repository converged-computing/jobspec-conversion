#!/bin/bash
#FLUX: --job-name=buttery-bike-5353
#FLUX: --priority=16

eval "$(conda shell.bash hook)"
conda activate m3
python main.py --config config/prova_residual.yaml
