#!/bin/bash
#FLUX --job-name=fuzzy-car-2276
#FLUX -n=4
#FLUX --queue=cloud
#FLUX --urgency=16

module purge
module load singularity
singularity run nix-container-python.sif
