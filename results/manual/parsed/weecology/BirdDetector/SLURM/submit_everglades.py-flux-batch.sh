#!/bin/bash
#FLUX: --job-name=Everglades
#FLUX: -c=10
#FLUX: --queue=gpu
#FLUX: -t=18000
#FLUX: --urgency=16

source activate Zooniverse_pytorch
python everglades.py
