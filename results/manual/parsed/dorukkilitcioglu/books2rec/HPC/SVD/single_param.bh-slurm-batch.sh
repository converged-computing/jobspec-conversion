#!/bin/bash
#FLUX: --job-name=scruptious-soup-3225
#FLUX: -c=5
#FLUX: -t=43200
#FLUX: --urgency=16

module purge
python3 single_param.py
