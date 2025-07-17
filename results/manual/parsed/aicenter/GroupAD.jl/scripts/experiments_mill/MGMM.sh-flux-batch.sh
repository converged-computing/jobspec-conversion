#!/bin/bash
#FLUX: --job-name=arid-fudge-4930
#FLUX: --queue=cpufast
#FLUX: -t=14400
#FLUX: --urgency=16

MAX_SEED=$1
DATASET=$2
CONTAMINATION=$3
module load Python/3.8
module load Julia/1.7.3-linux-x86_64
julia --project ./MGMM.jl ${MAX_SEED} $DATASET $CONTAMINATION
