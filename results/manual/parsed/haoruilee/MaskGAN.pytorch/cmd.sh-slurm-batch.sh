#!/bin/bash
#FLUX: --job-name=maskgan
#FLUX: -n=36
#FLUX: --urgency=16

module load use.own
module load python/3.7.0
python3 -W ignore -m mgan.main --path datasets/aclImdb/ --spm_prefix datasets/aclImdb/train/imdb
