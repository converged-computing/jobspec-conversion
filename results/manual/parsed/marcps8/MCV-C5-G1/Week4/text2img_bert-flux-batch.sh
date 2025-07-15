#!/bin/bash
#FLUX: --job-name=outstanding-fudge-2775
#FLUX: --priority=16

python retrieval_txt2img.py --text-model bert --model-name text2img_25perc_bert.pth --mode text2img
