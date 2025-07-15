#!/bin/bash
#FLUX: --job-name=picklesauce
#FLUX: -t=14400
#FLUX: --urgency=16

export PYTHONUNBUFFERED='1'

date=$(date +%d_%m_%Y__%H_%M)
export PYTHONUNBUFFERED=1
module load cmake
module load gcc
module load python3
module load cuda/10.1
module load graphviz
conda activate /home/rusack/shared/.conda/env/torch1.7
