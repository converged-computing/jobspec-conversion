#!/bin/bash
#FLUX: --job-name=lovable-hobbit-6434
#FLUX: --urgency=16

node=$SLURM_JOB_NODELIST
module load tacc-apptainer
echo "Node Number: ${node}"
resnet-singularity-multi.sh
