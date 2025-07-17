#!/bin/bash
#FLUX: --job-name=milestoning
#FLUX: -c=4
#FLUX: --gpus-per-task=1
#FLUX: --queue=standard
#FLUX: -t=259200
#FLUX: --urgency=16

module load cuda/10.1.243
module load namd/2.14b2/gcc.8.4.0-cuda.10.1.243
source /data/homezvol2/dray1/Miniconda2/etc/profile.d/conda.sh
source env.sh
mv west.log west.log.old 
rm binbounds.txt
$WEST_ROOT/bin/w_run -r west.cfg --work-manager processes --n-workers 1 "$@" &> west.log
