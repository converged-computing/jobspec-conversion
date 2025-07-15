#!/bin/bash
#FLUX: --job-name=loopy-salad-8935
#FLUX: --urgency=16

node=$SLURM_JOB_NODELIST
echo "Node Number: ${node}"
run-resnet.sh
