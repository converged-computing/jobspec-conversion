#!/bin/bash
#FLUX: --job-name=delicious-knife-4585
#FLUX: -t=18000
#FLUX: --urgency=16

module restore uneq
cd ..
mkdir -p ./Korcan/Plots/resnet/FEC\ \(IID\)/
python Korcan/pipeline.py $(($(($SLURM_ARRAY_TASK_ID-1))*10)) 5 20 70
