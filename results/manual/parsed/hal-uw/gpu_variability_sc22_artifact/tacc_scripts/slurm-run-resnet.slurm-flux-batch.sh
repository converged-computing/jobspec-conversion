#!/bin/bash
#FLUX: --job-name=muffled-dog-3528
#FLUX: --priority=16

node=$SLURM_JOB_NODELIST
echo "Node Number: ${node}"
run-resnet.sh
