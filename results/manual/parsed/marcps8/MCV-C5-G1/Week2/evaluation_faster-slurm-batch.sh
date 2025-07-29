#!/bin/bash
#FLUX: --job-name=crusty-bicycle-0809
#FLUX: -n=4
#FLUX: --queue=mhigh,mhigh
#FLUX: --urgency=16

python evaluation.py --model-index 1
