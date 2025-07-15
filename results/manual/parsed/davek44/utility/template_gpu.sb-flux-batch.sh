#!/bin/bash
#FLUX: --job-name=frigid-leg-3832
#FLUX: -t=172800
#FLUX: --priority=16

. /home/drk/anaconda3/etc/profile.d/conda.sh
conda activate tf210
basenji_train.py
