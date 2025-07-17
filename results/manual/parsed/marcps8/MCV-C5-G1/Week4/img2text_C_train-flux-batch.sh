#!/bin/bash
#FLUX: --job-name=goodbye-avocado-7849
#FLUX: -n=8
#FLUX: --queue=mlow,mlow
#FLUX: --urgency=16

python img2text_notonline.py --text-model fasttext
