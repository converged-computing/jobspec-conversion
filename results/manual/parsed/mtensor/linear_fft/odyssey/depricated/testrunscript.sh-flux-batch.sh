#!/bin/bash
#FLUX: --job-name=muffled-citrus-8079
#FLUX: --urgency=16

module load gcc/4.9.3-fasrc01 tensorflow/0.12.0-fasrc02
python fouriernetwork_odyssey64.py
