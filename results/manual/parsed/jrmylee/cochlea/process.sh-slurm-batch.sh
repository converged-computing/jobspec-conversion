#!/bin/bash
#FLUX: --job-name=daniil
#FLUX: -c=2
#FLUX: --queue=savio2_gpu
#FLUX: -t=86400
#FLUX: --urgency=16

module load pytorch/1.0.0-py36-cuda9.0 libsndfile
python -u main.py
