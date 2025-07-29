#!/bin/bash
#FLUX --job-name=delicious-citrus-8763
#FLUX -n=8
#FLUX --queue=mlow,mlow
#FLUX --urgency=16

python text2img.py --epochs 5 --text-model fasttext
