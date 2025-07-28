#!/bin/bash
#FLUX: --job-name=soy_test_alignment
#FLUX: -n=72
#FLUX: --exclusive
#FLUX: -t=43200
#FLUX: --urgency=16

module load singularity
singularity exec conda.sif R CMD BATCH run.R
