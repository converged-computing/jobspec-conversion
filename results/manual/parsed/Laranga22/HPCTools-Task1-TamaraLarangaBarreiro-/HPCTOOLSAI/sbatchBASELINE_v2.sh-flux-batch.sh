#!/bin/bash
#FLUX: --job-name=baseline-torch
#FLUX: -t=1800
#FLUX: --urgency=16

source $STORE/mytorchdist/bin/deactivate
source $STORE/mytorchdist/bin/activate
which python
python lightningDDP_v2.py
