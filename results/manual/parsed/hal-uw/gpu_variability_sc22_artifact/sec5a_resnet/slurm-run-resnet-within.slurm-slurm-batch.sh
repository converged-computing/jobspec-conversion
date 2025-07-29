#!/bin/bash
#FLUX: --job-name=resnet-within
#FLUX: --queue=rtx-dev
#FLUX: -t=7200
#FLUX: --urgency=16

node=$SLURM_JOB_NODELIST
module load tacc-apptainer
echo "Node Number: ${node}"
resnet-singularity-multi.sh
