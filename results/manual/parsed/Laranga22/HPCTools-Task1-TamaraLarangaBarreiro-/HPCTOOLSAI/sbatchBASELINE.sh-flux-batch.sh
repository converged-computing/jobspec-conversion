#!/bin/bash
#FLUX: --job-name=baseline-torch
#FLUX: -t=9900
#FLUX: --urgency=16

source $STORE/mytorchdist/bin/deactivate
source $STORE/mytorchdist/bin/activate
which python
python BASELINE.py
