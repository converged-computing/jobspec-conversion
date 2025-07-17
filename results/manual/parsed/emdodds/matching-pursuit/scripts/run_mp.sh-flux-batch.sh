#!/bin/bash
#FLUX: --job-name=adorable-carrot-4606
#FLUX: --queue=cortex
#FLUX: -t=172800
#FLUX: --urgency=16

export MODULEPATH='/global/software/sl-6.x64_64/modfiles/apps:$MODULEPATH'

cd /global/home/users/edodds/matching-pursuit
export MODULEPATH=/global/software/sl-6.x64_64/modfiles/apps:$MODULEPATH
module load ml/tensorflow/0.12.1
python scripts/fit_mp.py
