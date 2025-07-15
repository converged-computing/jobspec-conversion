#!/bin/bash
#FLUX: --job-name=fuzzy-puppy-1859
#FLUX: --queue=cpufast
#FLUX: -t=3600
#FLUX: --urgency=16

MODEL=$1 		# which model to run
DATASET=$2      # which dataset to run
DATASET_TYPE=$3	# images | tabular
module load Julia/1.5.3-linux-x86_64
module load Python/3.8.2-GCCcore-9.3.0
julia --project ./ensemble.jl $MODEL $DATASET $DATASET_TYPE 5 10
