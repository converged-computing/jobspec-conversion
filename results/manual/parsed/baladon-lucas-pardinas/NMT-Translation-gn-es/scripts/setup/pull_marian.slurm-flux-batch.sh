#!/bin/bash
#FLUX: --job-name=MARIAN
#FLUX: -c=4
#FLUX: --queue=normal
#FLUX: -t=86400
#FLUX: --priority=16

export SINGULARITY_TMPDIR='$(pwd)/cache'

echo starting download...
export SINGULARITY_TMPDIR=$(pwd)/cache
singularity pull docker://lefterav/marian-nmt:1.11.0_sentencepiece_cuda-11.3.0
