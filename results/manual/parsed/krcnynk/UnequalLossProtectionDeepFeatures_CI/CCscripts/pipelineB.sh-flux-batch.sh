#!/bin/bash
#FLUX: --job-name=delicious-pastry-0524
#FLUX: -t=14400
#FLUX: --urgency=16

module restore uneq
cd ..
mkdir -p ./Korcan/Plots/resnet/Least\ important/
python Korcan/pipeline.py $(($(($SLURM_ARRAY_TASK_ID-1))*10)) 2 0 0
