#!/bin/bash
#FLUX: --job-name=anxious-despacito-6033
#FLUX: -c=16
#FLUX: --queue=volta-hp
#FLUX: --priority=16

ch-run 'tensorflow.tensorflow:latest-gpu' -b /mnt/research/bures -c /home/bures/ftnn python3 preprocess_otf.py 1000
