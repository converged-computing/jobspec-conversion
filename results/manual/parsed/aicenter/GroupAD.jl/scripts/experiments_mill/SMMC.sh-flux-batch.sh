#!/bin/bash
#FLUX: --job-name=pusheena-soup-7538
#FLUX: --queue=cpufast
#FLUX: --urgency=16

MAX_SEED=$1
DATASET=$2
CONTAMINATION=$3
module load Python/3.8
module load Julia/1.7.3-linux-x86_64
julia --project ./SMMC_empirical.jl ${MAX_SEED} $DATASET $CONTAMINATION
