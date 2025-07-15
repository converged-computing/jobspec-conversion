#!/bin/bash
#FLUX: --job-name=wikiparser
#FLUX: -t=18000
#FLUX: --urgency=16

module add python
mapfile -t FILES < $1
FILENAME=${FILES[$SLURM_ARRAY_TASK_ID]}
python3 main.py $FILENAME $2 $3
