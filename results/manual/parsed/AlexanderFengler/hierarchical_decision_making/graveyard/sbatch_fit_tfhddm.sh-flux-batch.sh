#!/bin/bash
#FLUX: --job-name=hddm_fitting
#FLUX: -c=24
#FLUX: -t=64800
#FLUX: --urgency=16

python -u /users/tsumme/fit_hddm.py $1 $2 $3 $4
