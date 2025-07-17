#!/bin/bash
#FLUX: --job-name=creamy-kerfuffle-0552
#FLUX: -c=5
#FLUX: -t=172800
#FLUX: --urgency=16

module purge
python3 benchmark.py
