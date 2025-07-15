#!/bin/bash
#FLUX: --job-name=synthetic
#FLUX: -t=600
#FLUX: --urgency=16

      # nom du job
module load conda/py3-latest
source activate py310
python syntheticMonitoring.py
