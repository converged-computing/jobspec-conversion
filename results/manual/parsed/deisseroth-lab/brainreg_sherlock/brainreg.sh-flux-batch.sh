#!/bin/bash
#FLUX: --job-name=wobbly-chair-4415
#FLUX: --urgency=16

ml python/3.9 gcc
source ${GROUP_HOME}/projects/registration/brainreg/venv/bin/activate
echo "======"
echo "Params"
echo "$@"
echo "======"
brainreg "$@"
