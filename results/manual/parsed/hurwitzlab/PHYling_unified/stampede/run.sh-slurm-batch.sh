#!/bin/bash
#FLUX: --job-name=phyling
#FLUX: --queue=normal
#FLUX: -t=86400
#FLUX: --urgency=16

module load tacc-singularity
set -u
singularity run phyling.img
