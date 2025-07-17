#!/bin/bash
#FLUX: --job-name=binaural
#FLUX: -N=25
#FLUX: --queue=gpu
#FLUX: -t=28800
#FLUX: --urgency=16

source activate keras
python neuralnet.py
