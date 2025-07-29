#!/bin/bash
#FLUX --job-name=boopy-carrot-3630
#FLUX -n=8
#FLUX --queue=mlow,mlow
#FLUX --urgency=16

python img2text.py --epochs 2 --text-model fasttext
