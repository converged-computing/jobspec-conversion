#!/bin/bash
#FLUX: --job-name=phat-staircase-6120
#FLUX: -n=8
#FLUX: --queue=mlow,mlow
#FLUX: --urgency=16

python retrieval_txt2img.py --text-model bert --model-name text2img_25perc_bert.pth --mode text2img
