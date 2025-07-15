#!/bin/bash
#FLUX: --job-name=cil_train
#FLUX: -t=36000
#FLUX: --priority=16

source startup.sh
python train.py
