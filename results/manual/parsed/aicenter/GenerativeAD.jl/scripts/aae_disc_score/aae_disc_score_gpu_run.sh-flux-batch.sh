#!/bin/bash
#FLUX: --job-name=red-peas-1275
#FLUX: -c=2
#FLUX: --queue=gpu
#FLUX: -t=86400
#FLUX: --urgency=16

MODEL=$1
DATATYPE=$2
DATASET=$3
SEED=$4
AC=$5
module load Julia/1.5.1-linux-x86_64
module load Python/3.8.2-GCCcore-9.3.0
julia ./aae_disc_score.jl $MODEL $DATATYPE $DATASET $SEED $AC
