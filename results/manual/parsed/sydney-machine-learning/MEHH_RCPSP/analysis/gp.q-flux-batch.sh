#!/bin/bash
#FLUX: --job-name=test4
#FLUX: -n=20
#FLUX: -t=216000
#FLUX: --urgency=16

module load python/3.7.2
source $(which virtualenvwrapper_lazy.sh)
workon test
python params_gp.py
