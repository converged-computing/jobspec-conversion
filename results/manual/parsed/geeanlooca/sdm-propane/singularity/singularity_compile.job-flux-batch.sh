#!/bin/bash
#FLUX: --job-name=scruptious-peanut-7843
#FLUX: --urgency=16

srun singularity build --remote singularity_image.sif singularity/singularity_image.def
