#!/bin/bash
#FLUX: --job-name=delicious-plant-8798
#FLUX: --priority=16

python img2text.py --epochs 2 --text-model fasttext
