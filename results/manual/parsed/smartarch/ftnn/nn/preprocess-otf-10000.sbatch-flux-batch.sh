#!/bin/bash
#FLUX: --job-name=gloopy-frito-3384
#FLUX: -c=16
#FLUX: --queue=volta-lp
#FLUX: --urgency=16

ch-run 'tensorflow.tensorflow:latest-gpu' -b /mnt/research/bures -c /home/bures/ftnn python3 preprocess_otf.py 10000
