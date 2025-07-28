#!/bin/bash
#FLUX: --job-name=socialgame_train
#FLUX: -c=2
#FLUX: --queue=savio2
#FLUX: -t=3600
#FLUX: --urgency=16

singularity exec --nv --workdir ./tmp --bind $(pwd):$HOME library://aphoh/default/sg-k80-env:v1 sh -c './singularity_preamble.sh && ./planning_run.sh'
