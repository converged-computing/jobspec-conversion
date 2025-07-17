#!/bin/bash
#FLUX: --job-name=posets
#FLUX: --queue=gpu-shared
#FLUX: -t=1800
#FLUX: --urgency=16

module purge
module list
printenv
python3 spectrum.py
