#!/bin/bash
#FLUX: --job-name=dirty-sundae-9061
#FLUX: --urgency=16

python img2text.py --epochs 2 --text-model fasttext
