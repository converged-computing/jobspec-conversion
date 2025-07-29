#!/bin/bash
#FLUX: --job-name=evasive-despacito-0249
#FLUX: -n=8
#FLUX: --queue=mlow,mlow
#FLUX: --urgency=16

python img2text_notonline.py --text-model fasttext
