#!/bin/bash
#FLUX: --job-name=hairy-knife-4715
#FLUX: --queue=overflow
#FLUX: --priority=16

source /labs/hulab/stark_conda/bin/activate
conda activate base_pytorch
echo "JOB START"
nvidia-smi
python main.py
