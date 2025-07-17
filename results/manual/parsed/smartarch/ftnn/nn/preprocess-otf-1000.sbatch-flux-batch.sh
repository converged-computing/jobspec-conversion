#!/bin/bash
#FLUX: --job-name=fat-blackbean-8092
#FLUX: -c=16
#FLUX: --queue=volta-hp
#FLUX: --urgency=16

ch-run 'tensorflow.tensorflow:latest-gpu' -b /mnt/research/bures -c /home/bures/ftnn python3 preprocess_otf.py 1000
