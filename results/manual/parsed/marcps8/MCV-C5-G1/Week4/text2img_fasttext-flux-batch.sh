#!/bin/bash
#FLUX: --job-name=boopy-underoos-3144
#FLUX: --urgency=16

python text2img.py --epochs 5 --text-model fasttext
