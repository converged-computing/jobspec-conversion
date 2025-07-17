#!/bin/bash
#FLUX: --job-name=resnet
#FLUX: --queue=gpu-a100
#FLUX: -t=7200
#FLUX: --urgency=16

node=$SLURM_JOB_NODELIST
module load tacc-apptainer
echo "Node Number: ${node}"
./resnet-singularity-single.sh
