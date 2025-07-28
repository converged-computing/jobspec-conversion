#!/bin/bash
#FLUX: --job-name=red-lemon-8044
#FLUX: -n=4
#FLUX: --queue=cloud
#FLUX: --urgency=16

module purge
module load singularity
singularity run nix-container-python.sif
