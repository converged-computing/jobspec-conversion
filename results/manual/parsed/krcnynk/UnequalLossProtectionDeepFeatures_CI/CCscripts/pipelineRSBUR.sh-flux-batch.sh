#!/bin/bash
#FLUX: --job-name=muffled-omelette-3304
#FLUX: -t=14400
#FLUX: --urgency=16

module restore uneq
cd ..
python Korcan/pipeline.py $(($(($SLURM_ARRAY_TASK_ID-1))*10)) 6 40 60
