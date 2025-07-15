#!/bin/bash
#FLUX: --job-name=surf
#FLUX: -c=28
#FLUX: -t=36000
#FLUX: --priority=16

module purge
module load gcc/10.2.0
module load cuda/11.1.74
module load boost/intel/1.74.0
module load matlab/2020b
theme=$1
date
pid=""
python LGN_surfaceGrid.py $theme &
pid+="${!} "
wait $pid
date
