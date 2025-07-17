#!/bin/bash
#FLUX: --job-name=item2vectrans
#FLUX: -c=30
#FLUX: --queue=gpu
#FLUX: -t=1382400
#FLUX: --urgency=16

module list
python  src/recsys23/main.py 
