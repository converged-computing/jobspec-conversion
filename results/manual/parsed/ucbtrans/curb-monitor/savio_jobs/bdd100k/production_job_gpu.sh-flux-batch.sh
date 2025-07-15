#!/bin/bash
#FLUX: --job-name=pre-process-model-training-gpu-prod
#FLUX: -c=4
#FLUX: --queue=savio3_gpu
#FLUX: -t=259200
#FLUX: --urgency=16

module load python gcc opencv cmake
pip install --user --upgrade pip setuptools wheel && pip install --user -r ~/curb-monitor/requirements.txt
cd ~/curb-monitor && python ./training/bdd100k/train.py
