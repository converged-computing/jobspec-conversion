#!/bin/bash
#FLUX: --job-name=strawberry-parrot-9628
#FLUX: -n=8
#FLUX: --queue=mlow,mlow
#FLUX: --urgency=16

python retrieval.py --text-model bert --model-name text2img_25perc_bert.pth
