#!/bin/bash
#FLUX: --job-name=crunchy-peanut-4106
#FLUX: --queue=overflow
#FLUX: --urgency=16

source /labs/hulab/stark_conda/bin/activate
conda activate base_pytorch
echo "JOB START"
nvidia-smi
python main.py
