#!/bin/bash
#FLUX: --job-name=AmoebaNetEvolver
#FLUX: --queue=gpu
#FLUX: -t=1800000
#FLUX: --priority=16

export PYTHONPATH='$PYTHONPATH:/users/40175159/gridware/share/python/3.6.4/lib/python3.6/site-packages'

module add nvidia-cuda
module add apps/python3
nvidia-smi
export PYTHONPATH=$PYTHONPATH:/users/40175159/gridware/share/python/3.6.4/lib/python3.6/site-packages
python3 main.py --device cuda --population_size 4
