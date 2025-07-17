#!/bin/bash
#FLUX: --job-name=tensorflow
#FLUX: --queue=v100x8
#FLUX: -t=60
#FLUX: --urgency=16

module purge
module load tensorflow
python3 example.py
