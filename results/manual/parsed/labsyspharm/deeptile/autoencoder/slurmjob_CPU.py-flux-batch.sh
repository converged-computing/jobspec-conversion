#!/bin/bash
#FLUX: --job-name=getNorm
#FLUX: --priority=16

module load gcc/6.2.0 python/3.6.0
source /home/hw233/virtualenv/py3/bin/activate
python get_tile_normalizer.py -n 20
