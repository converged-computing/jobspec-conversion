#!/bin/bash
#FLUX: --job-name=reclusive-soup-0775
#FLUX: --queue=overflow
#FLUX: --urgency=16

source /labs/hulab/stark_conda/bin/activate
conda activate base_pytorch
echo "JOB START"
nvidia-smi
python main.py
