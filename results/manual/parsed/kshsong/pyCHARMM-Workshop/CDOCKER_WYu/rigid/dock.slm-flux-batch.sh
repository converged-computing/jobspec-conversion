#!/bin/bash
#FLUX: --job-name=rigid
#FLUX: --queue=gpu2080
#FLUX: -t=18000
#FLUX: --urgency=16

module load pycharmm/0.5
python standard.py
