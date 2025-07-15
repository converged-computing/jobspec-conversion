#!/bin/bash
#FLUX: --job-name=gassy-itch-9265
#FLUX: -t=14400
#FLUX: --urgency=16

module restore uneq
cd ..
mkdir -p ./Korcan/Plots/resnet/Most\ important/
python Korcan/pipeline.py $(($(($SLURM_ARRAY_TASK_ID-1))*10)) 1 0 0
