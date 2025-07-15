#!/bin/bash
#FLUX: --job-name=joyous-general-3162
#FLUX: -t=86400
#FLUX: --priority=16

module load ccbrpipeliner
module load nextflow
NXF_SINGULARITY_CACHEDIR=/data/CCBR_Pipeliner/SIFS
