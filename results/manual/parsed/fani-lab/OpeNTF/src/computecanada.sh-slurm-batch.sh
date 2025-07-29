#!/bin/bash
#FLUX: --job-name=fat-knife-5809
#FLUX: -t=172800
#FLUX: --urgency=16

python -u main.py -data ../data/raw/dblp/dblp.v12.json -domain dblp -model bnn -filter 1
