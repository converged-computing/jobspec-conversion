#!/bin/bash
#FLUX: --job-name=moolicious-salad-8788
#FLUX: -c=2
#FLUX: --queue=gpu
#FLUX: -t=86400
#FLUX: --urgency=16

DATASET=$1
module load Julia/1.5.1-linux-x86_64
module load Python/3.8.2-GCCcore-9.3.0
julia ./fAnoGAN.jl $DATASET
