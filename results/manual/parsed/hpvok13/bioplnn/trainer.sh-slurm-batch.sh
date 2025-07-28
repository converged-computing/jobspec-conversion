#!/bin/bash
#FLUX: --job-name=trainer
#FLUX: -c=8
#FLUX: -t=86400
#FLUX: --urgency=16

source ~/.bashrc
conda activate pytorch
python -u src/bioplnn/topography_trainer.py --config config/config_topography_random.yaml
