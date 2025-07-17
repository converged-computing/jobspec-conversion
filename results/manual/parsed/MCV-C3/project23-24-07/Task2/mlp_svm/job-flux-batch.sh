#!/bin/bash
#FLUX: --job-name=moolicious-lemon-6835
#FLUX: -n=4
#FLUX: --queue=mlow,mlow
#FLUX: --urgency=16

SAVE_DIR=$1
sleep 1
python mlp_and_svm.py $SAVE_DIR $2
