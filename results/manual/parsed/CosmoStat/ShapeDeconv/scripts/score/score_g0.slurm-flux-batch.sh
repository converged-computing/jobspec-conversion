#!/bin/bash
#FLUX: --job-name=tikho_train
#FLUX: -c=10
#FLUX: -t=50400
#FLUX: --urgency=16

export PYTHONPATH='$PYTHONPATH:$WORK/GitHub/score'

module purge
module load tensorflow-gpu/py3/1.15.2
set -x
export PYTHONPATH="$PYTHONPATH:$WORK/GitHub/alpha-transform"
export PYTHONPATH="$PYTHONPATH:$WORK/GitHub/score"
cd $WORK/GitHub/ShapeDeconv/scripts
python ./score_g0.py
