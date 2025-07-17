#!/bin/bash
#FLUX: --job-name=milky-snack-8258
#FLUX: -t=86400
#FLUX: --urgency=16

module restore uneq
cd ..
mkdir -p ./Korcan/Plots/resnet/FEC\ \(IID\)\ NS\ Weighted/
python Korcan/pipeline.py $(($(($SLURM_ARRAY_TASK_ID-1))*10)) 20 30 70
python Korcan/pipeline.py $(($(($SLURM_ARRAY_TASK_ID-1))+30)) 20 30 70
