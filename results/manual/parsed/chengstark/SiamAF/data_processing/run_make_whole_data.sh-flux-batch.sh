#!/bin/bash
#FLUX: --job-name=cowy-nalgas-2144
#FLUX: -c=16
#FLUX: --queue=overflow
#FLUX: -t=14400
#FLUX: --urgency=16

source /labs/hulab/stark_conda/bin/activate
conda activate base_pytorch
echo "JOB START"
nvidia-smi
python make_whole_data.py
