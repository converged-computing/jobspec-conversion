#!/bin/bash
#FLUX: --job-name=boopy-leader-4801
#FLUX: --urgency=16

eval "$(conda shell.bash hook)"
conda activate m3
python main.py --config config/prova_residual.yaml
