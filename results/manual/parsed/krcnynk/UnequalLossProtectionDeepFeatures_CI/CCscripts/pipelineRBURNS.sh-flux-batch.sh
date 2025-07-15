#!/bin/bash
#FLUX: --job-name=strawberry-nunchucks-4132
#FLUX: -t=14400
#FLUX: --urgency=16

module restore uneq
cd ..
python Korcan/pipeline.py $(($(($SLURM_ARRAY_TASK_ID-1))*10)) 8 0 0
