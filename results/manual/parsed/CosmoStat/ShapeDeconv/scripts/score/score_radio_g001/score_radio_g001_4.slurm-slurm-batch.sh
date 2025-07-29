#!/bin/bash
#FLUX: --job-name=score_radio_g001_4
#FLUX: -c=10
#FLUX: -t=72000
#FLUX: --urgency=16

export PYTHONPATH='$PYTHONPATH:$WORK/GitHub/score'

module purge
module load tensorflow-gpu/py3/1.15.2
set -x
export PYTHONPATH="$PYTHONPATH:$WORK/GitHub/alpha-transform"
export PYTHONPATH="$PYTHONPATH:$WORK/GitHub/score"
cd $WORK/GitHub/ShapeDeconv/scripts/score/score_radio_g001
python ./score_radio_g001_4.py
