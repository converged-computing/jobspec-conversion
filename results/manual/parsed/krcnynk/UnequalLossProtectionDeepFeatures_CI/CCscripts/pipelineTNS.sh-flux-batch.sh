#!/bin/bash
#FLUX: --job-name=fat-pancake-5698
#FLUX: -t=14400
#FLUX: --urgency=16

module restore uneq
cd ..
python Korcan/pipeline.py $(($(($SLURM_ARRAY_TASK_ID-1))*10)) 13 0 0
