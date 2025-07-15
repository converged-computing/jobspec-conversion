#!/bin/bash
#FLUX: --job-name=covidRCT
#FLUX: --queue=panda
#FLUX: --priority=16

echo "$SLURM_ARRAY_TASK_ID"
source ~/.bashrc
spack load -r /bxc56dm
Rscript simulate.R ${1}
exit 0
