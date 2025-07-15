#!/bin/bash
#FLUX: --job-name=MARIAN
#FLUX: -n=4
#FLUX: -c=9
#FLUX: --queue=normal
#FLUX: -t=432000
#FLUX: --priority=16

export SINGULARITY_TMPDIR='${HOME}/cache'
export TMPDIR='$SINGULARITY_TMPDIR'
export PYTHONPATH='${HOME}/libs'

cd ..
SCRIPT_NAME=$1
HOME=/docker/home
SCRIPT_PATH=${HOME}/scripts/${SCRIPT_NAME}
export SINGULARITY_TMPDIR=${HOME}/cache
export TMPDIR=$SINGULARITY_TMPDIR
chmod +x scripts/${SCRIPT_NAME}
export PYTHONPATH=${HOME}/libs
singularity exec -H ${HOME}/marianmt  --nv --no-home --contain --bind $(pwd):$HOME marian-nmt_1.11.0_sentencepiece_cuda-11.3.0.sif $SCRIPT_PATH
