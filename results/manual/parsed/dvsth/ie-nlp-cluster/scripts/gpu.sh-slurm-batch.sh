#!/bin/bash
#FLUX: --job-name=ieneurips
#FLUX: -c=6
#FLUX: --queue=compsci-gpu
#FLUX: --urgency=16

hostname
nvidia-smi --query-gpu=gpu_name,memory.total,memory.free --format=csv
source env/bin/activate
echo 'env started'
time python3 nlp.py
echo 'done'
