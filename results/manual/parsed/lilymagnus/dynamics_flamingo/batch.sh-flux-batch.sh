#!/bin/bash
#FLUX: --job-name=fat-knife-2812
#FLUX: --urgency=16

module purge
module load python/3.10.12
python3 accretion.py
