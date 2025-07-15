#!/bin/bash
#FLUX: --job-name=outstanding-leg-5909
#FLUX: -c=8
#FLUX: -t=28800
#FLUX: --priority=16

export MPLBACKEND='agg'

nvidia-smi
module load python/3.8
source ~/ENV_new/bin/activate
export MPLBACKEND=agg
python research/dmri_hippo/generate_parallel_commands.py | parallel --jobs 3
