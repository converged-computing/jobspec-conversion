#!/bin/bash
#FLUX: --job-name=adorable-truffle-9195
#FLUX: -t=14400
#FLUX: --priority=16

module restore uneq
cd ..
mkdir -p ./Korcan/Plots/resnet/Least\ important/
python Korcan/pipeline.py $(($(($SLURM_ARRAY_TASK_ID-1))*10)) 2 0 0
