#!/bin/bash
#FLUX: --job-name=gloopy-chair-2304
#FLUX: --urgency=16

module purge
module load singularity
singularity run nix-container-python.sif
