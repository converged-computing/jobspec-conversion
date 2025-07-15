#!/bin/bash
#FLUX: --job-name=delicious-hobbit-4559
#FLUX: --priority=16

eval "$(conda shell.bash hook)"
conda activate m3
python main.py --config config/prova_mish.yaml
