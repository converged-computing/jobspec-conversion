#!/bin/bash
#FLUX: --job-name=rainbow-diablo-5589
#FLUX: --urgency=16

node=$SLURM_JOB_NODELIST
module load tacc-apptainer
echo "Node Number: ${node}"
./resnet-singularity-single.sh
