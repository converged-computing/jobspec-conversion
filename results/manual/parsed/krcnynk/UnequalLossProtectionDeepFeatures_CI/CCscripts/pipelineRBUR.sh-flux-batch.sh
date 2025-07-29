#!/bin/bash
#FLUX --job-name=phat-leader-3835
#FLUX -t=14400
#FLUX --urgency=16

module restore uneq
cd ..
python Korcan/pipeline.py $(($(($SLURM_ARRAY_TASK_ID-1))*10)) 4 0 0
