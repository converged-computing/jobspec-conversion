#!/bin/bash
#FLUX: --job-name=bricky-spoon-0555
#FLUX: -t=14400
#FLUX: --priority=16

module restore uneq
cd ..
python Korcan/pipeline.py $(($(($SLURM_ARRAY_TASK_ID-1))*10)) 6 40 60
