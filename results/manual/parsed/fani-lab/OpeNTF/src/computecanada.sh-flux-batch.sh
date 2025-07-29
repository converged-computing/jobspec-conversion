#!/bin/bash
#FLUX --job-name=bumfuzzled-knife-1097
#FLUX -t=172800
#FLUX --urgency=16

python -u main.py -data ../data/raw/dblp/dblp.v12.json -domain dblp -model bnn -filter 1
