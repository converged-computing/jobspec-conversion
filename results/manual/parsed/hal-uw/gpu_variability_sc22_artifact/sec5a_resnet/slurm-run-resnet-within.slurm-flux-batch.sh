#!/bin/bash
#FLUX: --job-name=reclusive-bike-3393
#FLUX: --priority=16

node=$SLURM_JOB_NODELIST
module load tacc-apptainer
echo "Node Number: ${node}"
resnet-singularity-multi.sh
