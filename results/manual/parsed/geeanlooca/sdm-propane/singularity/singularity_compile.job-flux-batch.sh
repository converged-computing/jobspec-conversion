#!/bin/bash
#FLUX: --job-name=singularity_build
#FLUX: --queue=allgroups
#FLUX: --urgency=16

srun singularity build --remote singularity_image.sif singularity/singularity_image.def
