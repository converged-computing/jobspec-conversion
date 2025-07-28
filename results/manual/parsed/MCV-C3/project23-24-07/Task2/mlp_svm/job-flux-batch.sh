#!/bin/bash
#FLUX: --job-name=stanky-pancake-1112
#FLUX: -n=4
#FLUX: --queue=mlow,mlow
#FLUX: --urgency=16

SAVE_DIR=$1
sleep 1
python mlp_and_svm.py $SAVE_DIR $2
