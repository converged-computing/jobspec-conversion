#!/bin/bash
#FLUX: --job-name=sticky-peanut-3395
#FLUX: --queue=overflow
#FLUX: --priority=16

source /labs/hulab/stark_conda/bin/activate
conda activate base_pytorch
echo "JOB START"
nvidia-smi
python main.py
