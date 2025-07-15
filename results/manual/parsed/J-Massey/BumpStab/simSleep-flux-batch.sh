#!/bin/bash
#FLUX: --job-name=amd
#FLUX: -n=64
#FLUX: --queue=amd
#FLUX: -t=21600
#FLUX: --priority=16

echo "Starting calculation at $(date)"
echo "---------------------------------------------------------------"
module load openmpi/4.0.5/amd
module load conda
source activate rlotus
sleep 720000
