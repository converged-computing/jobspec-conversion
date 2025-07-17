#!/bin/bash
#FLUX: --job-name=HISROC13
#FLUX: -n=2
#FLUX: -c=2
#FLUX: -t=7800
#FLUX: --urgency=16

cd /home/um106329/aisafety
source ~/miniconda3/bin/activate
conda activate my-env
python3 eval_hist_roc.py
