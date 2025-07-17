#!/bin/bash
#FLUX: --job-name=cabinet
#FLUX: -c=24
#FLUX: --queue=v100
#FLUX: -t=86400
#FLUX: --urgency=16

module load singularity
module load python
singularity=`which singularity`
./run.py $1
