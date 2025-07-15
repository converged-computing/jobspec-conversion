#!/bin/bash
#FLUX: --job-name=goodbye-salad-3625
#FLUX: --priority=16

python retrieval2.py --text-model fasttext --model-name text2img_fasttext.pth
