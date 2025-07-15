#!/bin/bash
#FLUX: --job-name=grated-omelette-4783
#FLUX: --urgency=16

module load singularity
module load python
singularity=`which singularity`
./run.py $1
