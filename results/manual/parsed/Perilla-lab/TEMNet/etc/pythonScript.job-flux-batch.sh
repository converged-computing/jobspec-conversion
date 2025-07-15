#!/bin/bash
#FLUX: --job-name=chunky-chip-6312
#FLUX: --priority=16

USR_HOME=/home/07655/jsreyl/
NAME=$1
SCRIPT_DIR=`pwd`
time python3 $SCRIPT_DIR/$NAME
