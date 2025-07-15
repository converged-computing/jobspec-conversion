#!/bin/bash
#FLUX: --job-name=blank-peas-7612
#FLUX: --urgency=16

source ~/.bashrc
conda activate pytorch
python -u src/bioplnn/topography_trainer.py --config config/config_topography_random.yaml
