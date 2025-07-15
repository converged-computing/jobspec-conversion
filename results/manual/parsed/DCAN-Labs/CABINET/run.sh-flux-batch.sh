#!/bin/bash
#FLUX: --job-name=hairy-milkshake-8172
#FLUX: --priority=16

module load singularity
module load python
singularity=`which singularity`
./run.py $1
