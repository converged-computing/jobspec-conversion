#!/bin/bash
#FLUX: --job-name=milky-muffin-6998
#FLUX: --priority=16

python text2img.py --epochs 5 --text-model fasttext
