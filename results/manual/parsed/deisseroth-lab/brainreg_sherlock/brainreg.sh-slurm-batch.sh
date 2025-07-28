#!/bin/bash
#FLUX: --job-name=goodbye-animal-6720
#FLUX: -c=16
#FLUX: --queue=owners
#FLUX: -t=28800
#FLUX: --urgency=16

ml python/3.9 gcc
source ${GROUP_HOME}/projects/registration/brainreg/venv/bin/activate
echo "======"
echo "Params"
echo "$@"
echo "======"
brainreg "$@"
