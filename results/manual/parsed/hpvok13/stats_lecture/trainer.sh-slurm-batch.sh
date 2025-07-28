#!/bin/bash
#FLUX: --job-name=trainer
#FLUX: -c=4
#FLUX: -t=28800
#FLUX: --urgency=16

source ~/.bashrc
conda activate pytorch
python -u src/price_predictor/train.py --config config.yaml
