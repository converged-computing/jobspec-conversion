#!/bin/bash
#FLUX: --job-name=gloopy-blackbean-0172
#FLUX: -t=86100
#FLUX: --priority=16

module load tensorflow/1.13.1-py36-gpu
module load python/3.6.5
pip install --user --upgrade --ignore-installed numpy hyperopt ray
python3 scripts/hyperopt_search.py $@
