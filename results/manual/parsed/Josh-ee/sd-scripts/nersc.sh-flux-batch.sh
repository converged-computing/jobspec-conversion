#!/bin/bash
#FLUX: --job-name=sd-script
#FLUX: --queue=regular
#FLUX: -t=86340
#FLUX: --urgency=16

module load pytorch
source /pscratch/sd/y/yanggao/sd-scripts/venv/bin/activate
module load pytorch
python run.py
