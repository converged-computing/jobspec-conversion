#!/bin/bash
#FLUX: --job-name=peachy-onion-7109
#FLUX: -n=4
#FLUX: --queue=cloud
#FLUX: --urgency=16

module purge
module load singularity
singularity run nix-container-python.sif
