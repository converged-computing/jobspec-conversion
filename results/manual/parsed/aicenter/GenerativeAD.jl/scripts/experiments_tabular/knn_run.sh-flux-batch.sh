#!/bin/bash
#FLUX: --job-name=purple-punk-2253
#FLUX: -t=86400
#FLUX: --urgency=16

MAX_SEED=$1
DATASET=$2
HP_SAMPLING=$3
CONTAMINATION=$4
module load Julia/1.5.1-linux-x86_64
module load Python/3.8.2-GCCcore-9.3.0
julia ./knn.jl ${MAX_SEED} $DATASET ${HP_SAMPLING} $CONTAMINATION
