#!/bin/bash
#FLUX: --job-name=expressive-arm-6589
#FLUX: --urgency=16

module load pytorch
source /pscratch/sd/y/yanggao/sd-scripts/venv/bin/activate
module load pytorch
python run.py
