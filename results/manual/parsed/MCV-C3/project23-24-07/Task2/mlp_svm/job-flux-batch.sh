#!/bin/bash
#FLUX: --job-name=red-parrot-3670
#FLUX: --priority=16

SAVE_DIR=$1
sleep 1
python mlp_and_svm.py $SAVE_DIR $2
