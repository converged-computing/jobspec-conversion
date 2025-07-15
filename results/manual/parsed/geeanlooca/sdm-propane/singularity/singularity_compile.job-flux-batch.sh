#!/bin/bash
#FLUX: --job-name=strawberry-kitty-7291
#FLUX: --priority=16

srun singularity build --remote singularity_image.sif singularity/singularity_image.def
