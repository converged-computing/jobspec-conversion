#!/bin/bash
#FLUX: --job-name=joyous-hippo-2789
#FLUX: --urgency=16

python retrieval_txt2img.py --text-model bert --model-name text2img_25perc_bert.pth --mode text2img
