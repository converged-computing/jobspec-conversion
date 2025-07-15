#!/bin/bash
#FLUX: --job-name=grated-peas-0189
#FLUX: --priority=16

source ~/.bashrc
conda activate pytorch
python -u src/price_predictor/train.py --config config.yaml
