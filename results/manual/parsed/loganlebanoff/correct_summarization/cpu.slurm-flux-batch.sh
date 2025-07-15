#!/bin/bash
#FLUX: --job-name=astute-plant-7019
#FLUX: -c=8
#FLUX: -t=600
#FLUX: --priority=16

date
echo "Slurm nodes: $SLURM_JOB_NODELIST"
echo
echo "${1}"
echo
${1}
echo
echo "Ending script..."
date
