#!/bin/bash
#FLUX: --job-name=expressive-gato-8017
#FLUX: --priority=16

module purge
module load singularity
singularity run nix-container-python.sif
