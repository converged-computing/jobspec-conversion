#!/bin/bash
#FLUX: --job-name=gnn_2_1
#FLUX: --queue=main
#FLUX: -t=172800
#FLUX: --urgency=16

export PYTHONUNBUFFERED='1'

export PYTHONUNBUFFERED=1
module load cuda/10.2
module load anaconda
conda activate diffsub
python main.py with configs/zinc/node_del/del1_subgraph1_imle.yaml
