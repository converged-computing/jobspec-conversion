#!/bin/bash
#FLUX: --job-name=goodbye-leopard-0042
#FLUX: -c=8
#FLUX: -t=600
#FLUX: --urgency=16

date
echo "Slurm nodes: $SLURM_JOB_NODELIST"
echo
echo "${1}"
echo
${1}
echo
echo "Ending script..."
date
