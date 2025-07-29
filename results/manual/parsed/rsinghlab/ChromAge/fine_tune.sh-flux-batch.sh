#!/bin/bash
#FLUX --job-name=bricky-leader-2613
#FLUX -n=32
#FLUX -t=7200
#FLUX --urgency=16

module load python/3.7.4
source ChromAge_venv/bin/activate
python3 /users/masif/data/masif/ChromAge/simple_nn.py
deactivate
