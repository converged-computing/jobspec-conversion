#!/bin/bash
#FLUX --job-name=bumfuzzled-lemur-1115
#FLUX -c=8
#FLUX --queue=grete:shared
#FLUX -t=172800
#FLUX --urgency=16

source activate sam
python grid_search_and_inference.py $@
