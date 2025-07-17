#!/bin/bash
#FLUX: --job-name=fuzzy-chair-9043
#FLUX: -t=86400
#FLUX: --urgency=16

module restore uneq
cd ..
mkdir -p ./Korcan/Plots/resnet/FEC\ \(IID\)\ NS/
python Korcan/pipeline.py $(($(($SLURM_ARRAY_TASK_ID-1))+30)) 11 30 70
python Korcan/pipeline.py $(($(($SLURM_ARRAY_TASK_ID-1))*10)) 11 30 70
