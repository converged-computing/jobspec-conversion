#!/bin/bash
#FLUX: --job-name=lovable-truffle-0533
#FLUX: -t=14400
#FLUX: --priority=16

module restore uneq
cd ..
python Korcan/pipeline.py $(($(($SLURM_ARRAY_TASK_ID-1))*10)) 4 0 0
