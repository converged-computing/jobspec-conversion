#!/bin/bash
#FLUX: --job-name=elp
#FLUX: -N=2
#FLUX: -n=2
#FLUX: --queue=gpu
#FLUX: -t=86400
#FLUX: --urgency=16

ulimit -c 256
nvidia-smi
source activate lipinggpu
stdbuf -o0 python -u run-exp.py kegg_20_maccs -m ep -e pr --random_seed 1997
