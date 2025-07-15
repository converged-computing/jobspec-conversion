#!/bin/bash
#FLUX: --job-name=pusheena-leader-1326
#FLUX: -t=64800
#FLUX: --priority=16

python -u /users/tsumme/fit_hddm.py $1 $2 $3 $4
