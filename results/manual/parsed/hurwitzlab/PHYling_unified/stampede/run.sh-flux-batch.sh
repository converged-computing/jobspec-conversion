#!/bin/bash
#FLUX: --job-name=chocolate-house-5257
#FLUX: --urgency=16

module load tacc-singularity
set -u
singularity run phyling.img
