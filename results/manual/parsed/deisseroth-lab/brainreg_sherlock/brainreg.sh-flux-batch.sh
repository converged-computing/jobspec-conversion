#!/bin/bash
#FLUX: --job-name=scruptious-soup-5251
#FLUX: --priority=16

ml python/3.9 gcc
source ${GROUP_HOME}/projects/registration/brainreg/venv/bin/activate
echo "======"
echo "Params"
echo "$@"
echo "======"
brainreg "$@"
