#!/bin/bash
#FLUX: --job-name=conspicuous-milkshake-8828
#FLUX: --queue=cosma8
#FLUX: -t=10800
#FLUX: --urgency=16

module purge
module load python/3.10.12
python3 accretion.py
