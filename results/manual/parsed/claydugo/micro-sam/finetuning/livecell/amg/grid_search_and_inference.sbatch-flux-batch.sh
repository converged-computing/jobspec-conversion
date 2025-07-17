#!/bin/bash
#FLUX: --job-name=lovely-lemon-4912
#FLUX: -c=8
#FLUX: --queue=grete:shared
#FLUX: -t=172800
#FLUX: --urgency=16

source activate sam
python grid_search_and_inference.py $@
