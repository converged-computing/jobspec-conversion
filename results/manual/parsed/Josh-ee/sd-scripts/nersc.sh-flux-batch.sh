#!/bin/bash
#FLUX: --job-name=goodbye-itch-9629
#FLUX: --priority=16

module load pytorch
source /pscratch/sd/y/yanggao/sd-scripts/venv/bin/activate
module load pytorch
python run.py
