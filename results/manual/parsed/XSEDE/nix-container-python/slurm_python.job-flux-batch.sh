#!/bin/bash
#FLUX --job-name=blue-staircase-5600
#FLUX -n=4
#FLUX --queue=cloud
#FLUX --urgency=16

module purge
module load singularity
singularity run nix-container-python.sif
