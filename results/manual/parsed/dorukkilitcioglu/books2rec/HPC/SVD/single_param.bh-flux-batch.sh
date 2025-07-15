#!/bin/bash
#FLUX: --job-name=gloopy-parsnip-1499
#FLUX: -c=5
#FLUX: -t=43200
#FLUX: --urgency=16

module purge
python3 single_param.py
