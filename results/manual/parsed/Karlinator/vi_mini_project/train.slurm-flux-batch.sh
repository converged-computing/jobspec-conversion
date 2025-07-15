#!/bin/bash
#FLUX: --job-name=vi-mini-project
#FLUX: --queue=GPUQ
#FLUX: -t=28800
#FLUX: --urgency=16

module load Python/3.10.8-GCCcore-12.2.0
source venv/bin/activate
python main.py train -e 100
