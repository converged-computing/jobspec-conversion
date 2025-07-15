#!/bin/bash
#FLUX: --job-name=psycho-egg-7104
#FLUX: -t=86400
#FLUX: --urgency=16

module load ccbrpipeliner
module load nextflow
NXF_SINGULARITY_CACHEDIR=/data/CCBR_Pipeliner/SIFS
