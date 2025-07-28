#!/bin/bash
#FLUX: --job-name=sticky-mango-7582
#FLUX: --queue=overflow
#FLUX: -t=864000
#FLUX: --urgency=16

source /labs/hulab/stark_conda/bin/activate
conda activate base_pytorch
echo "JOB START"
nvidia-smi
python main.py
