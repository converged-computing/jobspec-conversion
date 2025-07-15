#!/bin/bash
#FLUX: --job-name=bumfuzzled-signal-3066
#FLUX: --priority=16

python retrieval.py --text-model bert --model-name text2img_25perc_bert.pth
