#!/bin/bash
#FLUX: --job-name=fuzzy-cinnamonbun-9813
#FLUX: --queue=overflow
#FLUX: --priority=16

source /labs/hulab/stark_conda/bin/activate
conda activate base_pytorch
echo "JOB START"
nvidia-smi
python main.py
