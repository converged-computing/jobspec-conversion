#!/bin/bash
#FLUX: --job-name=hairy-dog-7100
#FLUX: -c=16
#FLUX: --queue=overflow
#FLUX: --priority=16

source /labs/hulab/stark_conda/bin/activate
conda activate base_pytorch
echo "JOB START"
nvidia-smi
python make_whole_data.py
