#!/bin/bash
#FLUX: --job-name=adorable-truffle-1746
#FLUX: --priority=16

module load python/3.7.4
source ChromAge_venv/bin/activate
python3 /users/masif/data/masif/ChromAge/simple_nn.py
deactivate
