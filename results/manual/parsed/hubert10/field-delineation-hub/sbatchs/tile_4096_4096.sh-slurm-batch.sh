#!/bin/bash
#FLUX: --job-name=cpu_job_tile_4096_4096
#FLUX: -c=32
#FLUX: -t=25200
#FLUX: --urgency=16

pwd; hostname; date
module load tensorflow/2.4.1
python make_predictions.py
date
