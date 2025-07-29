#!/bin/bash
#FLUX: --job-name=getNorm
#FLUX: -n=20
#FLUX: --queue=priority
#FLUX: -t=180
#FLUX: --urgency=16

module load gcc/6.2.0 python/3.6.0
source /home/hw233/virtualenv/py3/bin/activate
python get_tile_normalizer.py -n 20
