#!/bin/bash
#FLUX --job-name=stanky-motorcycle-1391
#FLUX -n=8
#FLUX --queue=mlow,mlow
#FLUX --urgency=16

python retrieval2.py --text-model fasttext --model-name text2img_fasttext.pth
