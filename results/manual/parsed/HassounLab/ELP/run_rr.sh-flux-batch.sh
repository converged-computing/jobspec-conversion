#!/bin/bash
#FLUX: --job-name=elp
#FLUX: -t=86400
#FLUX: --priority=16

export PYTHONPATH='/cluster/tufts/liulab/lib/anaconda3/envs/lipinggpu/lib/python3.7/site-packages/:$PYTHONPATH'

nvidia-smi
source activate lipinggpu
export PYTHONPATH="/cluster/tufts/liulab/lib/anaconda3/envs/lipinggpu/lib/python3.7/site-packages/:$PYTHONPATH"
stdbuf -o0 python -u run-exp.py kegg_20_maccs -m ep -e rr
