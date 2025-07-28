#!/bin/bash
#FLUX: --job-name=3/5_name
#FLUX: -c=2
#FLUX: --queue=gpu
#FLUX: -t=172800
#FLUX: --urgency=16

. /home/drk/anaconda3/etc/profile.d/conda.sh
conda activate tf210
basenji_train.py
