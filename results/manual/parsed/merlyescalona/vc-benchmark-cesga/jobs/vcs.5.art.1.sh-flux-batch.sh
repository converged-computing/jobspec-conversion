#!/bin/bash
#FLUX: --job-name=art
#FLUX: --queue=shared
#FLUX: --priority=16

echo -e "[$(date)]\nDefinition"
module load gcc/5.3.0 art/2016-06-05
correctID=$SLURM_ARRAY_TASK_ID
let correctID=correctID-1
filename="$1.$(printf "%04g" $correctID).sh"
bash $filename
module unload gcc/5.3.0 art/2016-06-05
