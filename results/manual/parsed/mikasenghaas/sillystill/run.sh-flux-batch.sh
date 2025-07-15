#!/bin/bash
#FLUX: --job-name=evasive-lemon-5356
#FLUX: -t=28800
#FLUX: --priority=16

module load gcc python 
source ~/venvs/sillystill/bin/activate
pip install -r requirements.txt
deactivate
