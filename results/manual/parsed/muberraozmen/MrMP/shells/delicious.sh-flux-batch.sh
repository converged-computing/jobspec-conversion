#!/bin/bash
#FLUX: --job-name=moolicious-hope-5317
#FLUX: -t=120
#FLUX: --urgency=16

dataset=delicious
cuda_on=$true
if [[ $SLURM_ARRAY_TASK_ID -eq 1 ]]; then
  name=eda
  python3.8 -u main.py -dataset $dataset -name $name -cuda_on $cuda_on
elif [[ $SLURM_ARRAY_TASK_ID -eq 2 ]]; then
  name=mrmp
  mrmp_on=$true
  python3.8 -u main.py -dataset $dataset -name $name -mrmp_on $mrmp_on -cuda_on $cuda_on
fi
