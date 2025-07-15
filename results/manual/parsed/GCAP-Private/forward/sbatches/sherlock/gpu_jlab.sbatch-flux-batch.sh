#!/bin/bash
#FLUX: --job-name=ornery-house-1977
#FLUX: --priority=16

PORT=$1
NOTEBOOK_DIR=$2
cd $NOTEBOOK_DIR
module load system
module load x11
module load stata
ml py-tensorflow/2.1.0_py36
STATATMP="/scratch/groups/maggiori/stata_tmp"
export STATATMP
~/.local/bin/jupyter lab --no-browser --port=$PORT
