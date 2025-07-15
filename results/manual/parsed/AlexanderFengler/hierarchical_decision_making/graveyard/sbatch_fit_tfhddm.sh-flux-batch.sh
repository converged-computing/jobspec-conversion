#!/bin/bash
#FLUX: --job-name=milky-motorcycle-8939
#FLUX: -t=64800
#FLUX: --urgency=16

python -u /users/tsumme/fit_hddm.py $1 $2 $3 $4
