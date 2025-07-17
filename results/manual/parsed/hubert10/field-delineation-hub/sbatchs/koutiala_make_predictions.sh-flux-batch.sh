#!/bin/bash
#FLUX: --job-name=cpu_job_predictions_koutiala
#FLUX: -c=32
#FLUX: -t=25200
#FLUX: --urgency=16

pwd; hostname; date
module load tensorflow/2.4.1
python field_delineation_end2end.py
date
