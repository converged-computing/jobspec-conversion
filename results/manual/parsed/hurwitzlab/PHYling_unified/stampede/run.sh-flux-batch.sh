#!/bin/bash
#FLUX: --job-name=bricky-kerfuffle-8082
#FLUX: --priority=16

module load tacc-singularity
set -u
singularity run phyling.img
