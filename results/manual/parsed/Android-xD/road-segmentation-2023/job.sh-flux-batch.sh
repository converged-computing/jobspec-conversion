#!/bin/bash
#FLUX: --job-name=cil_train
#FLUX: -n=4
#FLUX: -t=36000
#FLUX: --urgency=16

source startup.sh
python train.py
