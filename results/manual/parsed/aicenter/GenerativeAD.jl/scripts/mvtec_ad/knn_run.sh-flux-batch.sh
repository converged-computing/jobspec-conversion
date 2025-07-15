#!/bin/bash
#FLUX: --job-name=angry-nunchucks-4276
#FLUX: -c=2
#FLUX: -t=86400
#FLUX: --urgency=16

MAX_SEED=$1
CATEGORY=$2
CONTAMINATION=$3
module load Julia/1.5.1-linux-x86_64
module load Python/3.8.2-GCCcore-9.3.0
julia ./knn.jl ${MAX_SEED} $CATEGORY $CONTAMINATION
