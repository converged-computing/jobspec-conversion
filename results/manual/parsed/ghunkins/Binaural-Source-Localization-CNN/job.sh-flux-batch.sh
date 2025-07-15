#!/bin/bash
#FLUX: --job-name=binaural
#FLUX: -t=28800
#FLUX: --priority=16

source activate keras
python neuralnet.py
