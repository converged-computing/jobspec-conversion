#!/bin/bash
#FLUX: --job-name=generate
#FLUX: -t=86400
#FLUX: --urgency=16

python ggs/GWG.py experiment=generate/Diagonal-unsmoothed run.seed=$SLURM_ARRAY_TASK_ID 
