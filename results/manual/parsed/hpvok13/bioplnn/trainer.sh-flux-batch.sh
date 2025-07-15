#!/bin/bash
#FLUX: --job-name=butterscotch-cattywampus-5245
#FLUX: --priority=16

source ~/.bashrc
conda activate pytorch
python -u src/bioplnn/topography_trainer.py --config config/config_topography_random.yaml
