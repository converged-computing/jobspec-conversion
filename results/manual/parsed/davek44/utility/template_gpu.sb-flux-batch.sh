#!/bin/bash
#FLUX: --job-name=stinky-underoos-3520
#FLUX: -t=172800
#FLUX: --urgency=16

. /home/drk/anaconda3/etc/profile.d/conda.sh
conda activate tf210
basenji_train.py
