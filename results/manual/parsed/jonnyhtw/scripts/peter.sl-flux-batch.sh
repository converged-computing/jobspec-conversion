#!/bin/bash
#FLUX: --job-name=grated-staircase-0103
#FLUX: --queue=nesi_prepost
#FLUX: -t=1800
#FLUX: --urgency=16

cd /nesi/nobackup/niwa00013/williamsjh/nearline/niwa00013/williamsjh/cylc-run/u-bp908/share/data/History_Data
peter.py --year $SLURM_ARRAY_TASK_ID
