#!/bin/bash
#FLUX: --job-name=bikenwgrowth
#FLUX: --queue=red
#FLUX: -t=259140
#FLUX: --urgency=16

module load Anaconda3
. $(conda info --base)/etc/profile.d/conda.sh
conda activate OSMNX
if [ $# > 0 ]; then
    ~/.conda/envs/OSMNX/bin/python analysissupploop.py $1 $SLURM_ARRAY_TASK_ID
fi
