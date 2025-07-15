#!/bin/bash
#FLUX: --job-name=nerdy-peas-5737
#FLUX: -c=10
#FLUX: --queue=gpu
#FLUX: -t=900
#FLUX: --urgency=16

PYTHON=python3
if [ -n "$SING_IMAGE" ]; then
    PYTHON="singularity_wrapper exec python3"
    echo "Using Singularity image $SING_IMAGE"
fi
module list
set -xv
$PYTHON $*
