#!/bin/bash
#FLUX: --job-name=fuzzy-lizard-7606
#FLUX: -t=172800
#FLUX: --priority=16

python -u main.py -data ../data/raw/dblp/dblp.v12.json -domain dblp -model bnn -filter 1
