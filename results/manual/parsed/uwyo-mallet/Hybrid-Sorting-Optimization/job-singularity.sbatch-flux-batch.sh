#!/bin/bash
#FLUX: --job-name=Hybrid-Sort-Optimization
#FLUX: -t=82800
#FLUX: --priority=16

module load gcc/12.2.0
module load python/3.10.6
module load singularity
source /project/mallet/jarulsam/venv/bin/activate
cd /project/mallet/jarulsam/Hybrid-Sorting-Optimization
mkdir -p ./experiment
printf "%s " "$@"
printf "\n"
mkdir -p ./experiment
singularity run --bind ./experiment:/HSO/experiment "$@"
