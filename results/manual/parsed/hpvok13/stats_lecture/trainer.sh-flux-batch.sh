#!/bin/bash
#FLUX: --job-name=creamy-destiny-9655
#FLUX: --urgency=16

source ~/.bashrc
conda activate pytorch
python -u src/price_predictor/train.py --config config.yaml
