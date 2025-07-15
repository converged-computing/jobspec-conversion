#!/bin/bash
#FLUX: --job-name=CLHydro
#FLUX: -t=3600
#FLUX: --urgency=16

unset DISPLAY
module load python/2.7.8
module load amdappsdk/2.9
python visc.py
