#!/bin/bash
#FLUX: --job-name=elp
#FLUX: -N=2
#FLUX: -n=2
#FLUX: --queue=gpu
#FLUX: -t=86400
#FLUX: --urgency=16

nvidia-smi
source activate lipinggpu
stdbuf -o0 python -u run-exp.py kegg_20_node_only -m ep -e viz
stdbuf -o0 python -u run-exp.py kegg_20_maccs -m ep -e viz
