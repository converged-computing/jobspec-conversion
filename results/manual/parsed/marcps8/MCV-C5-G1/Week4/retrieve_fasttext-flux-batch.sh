#!/bin/bash
#FLUX: --job-name=fat-onion-6684
#FLUX: --urgency=16

python retrieval2.py --text-model fasttext --model-name text2img_fasttext.pth
