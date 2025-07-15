#!/bin/bash
#FLUX: --job-name=boopy-lentil-9204
#FLUX: -t=86400
#FLUX: --urgency=16

MAX_SEED=$1
DATASET=$2
TAB_NAME=$3
MI_ONLY=$4
CONTAMINATION=$5
module load Julia/1.5.1-linux-x86_64
module load Python/3.8.2-GCCcore-9.3.0
julia ./two-stage_ocsvm.jl ${MAX_SEED} $DATASET ${TAB_NAME} ${MI_ONLY} $CONTAMINATION
