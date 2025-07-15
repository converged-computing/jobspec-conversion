#!/bin/bash
#FLUX: --job-name=stanky-chip-3880
#FLUX: --priority=16

node=$SLURM_JOB_NODELIST
module load tacc-apptainer
echo "Node Number: ${node}"
./resnet-singularity-single.sh
