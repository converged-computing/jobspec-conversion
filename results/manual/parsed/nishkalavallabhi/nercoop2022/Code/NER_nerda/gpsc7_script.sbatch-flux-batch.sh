#!/bin/bash
#FLUX: --job-name=GPU-Mbert-Conll_nl-fine_tuning
#FLUX: -c=8
#FLUX: --gpus-per-task=1
#FLUX: --queue=gpu_a100
#FLUX: -t=86400
#FLUX: --priority=16

python sub_script.py
