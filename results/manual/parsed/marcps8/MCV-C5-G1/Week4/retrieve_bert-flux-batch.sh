#!/bin/bash
#FLUX: --job-name=fugly-animal-6324
#FLUX: --urgency=16

python retrieval.py --text-model bert --model-name text2img_25perc_bert.pth
