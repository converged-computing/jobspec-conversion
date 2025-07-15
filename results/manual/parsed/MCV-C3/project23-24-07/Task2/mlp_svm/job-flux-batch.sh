#!/bin/bash
#FLUX: --job-name=joyous-pedo-6627
#FLUX: --urgency=16

SAVE_DIR=$1
sleep 1
python mlp_and_svm.py $SAVE_DIR $2
