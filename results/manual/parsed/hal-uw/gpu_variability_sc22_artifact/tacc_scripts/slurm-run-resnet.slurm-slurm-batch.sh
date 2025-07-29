#!/bin/bash
#FLUX: --job-name=resnet
#FLUX: --queue=v100
#FLUX: -t=7200
#FLUX: --urgency=16

node=$SLURM_JOB_NODELIST
echo "Node Number: ${node}"
run-resnet.sh
