#!/bin/bash
#FLUX: --job-name=outstanding-poo-4050
#FLUX: -t=14400
#FLUX: --priority=16

module restore uneq
cd ..
python Korcan/pipeline.py $(($(($SLURM_ARRAY_TASK_ID-1))*10)) 8 0 0
