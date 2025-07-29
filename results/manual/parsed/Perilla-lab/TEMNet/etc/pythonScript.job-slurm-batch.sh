#!/bin/bash
#FLUX: --job-name=hivclass-train
#FLUX: --queue=v100
#FLUX: -t=28800
#FLUX: --urgency=16

USR_HOME=/home/07655/jsreyl/
NAME=$1
SCRIPT_DIR=`pwd`
time python3 $SCRIPT_DIR/$NAME
