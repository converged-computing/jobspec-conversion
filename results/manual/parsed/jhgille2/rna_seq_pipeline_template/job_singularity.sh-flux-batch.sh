#!/bin/bash
#FLUX: --job-name=soy_test_alignment
#FLUX: --exclusive
#FLUX: --priority=16

module load singularity
singularity exec conda.sif R CMD BATCH run.R
