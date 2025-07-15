#!/bin/bash
#FLUX: --job-name=fmnist_fur_tests
#FLUX: -t=28800
#FLUX: --urgency=16

cd $HOME/repos/CosDefence/federated_learning
module switch intel gcc
module load python/3.8.7
module load cuda/11.1
module load cudnn/8.0.5
python3 run_config_variations.py fmnist_modified.yaml
