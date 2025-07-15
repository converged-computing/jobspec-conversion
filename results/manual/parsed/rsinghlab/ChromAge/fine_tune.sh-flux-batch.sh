#!/bin/bash
#FLUX: --job-name=nerdy-muffin-1090
#FLUX: --urgency=16

module load python/3.7.4
source ChromAge_venv/bin/activate
python3 /users/masif/data/masif/ChromAge/simple_nn.py
deactivate
