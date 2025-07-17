#!/bin/bash
#FLUX: --job-name=dirty-itch-4284
#FLUX: -c=32
#FLUX: --queue=gpusmall
#FLUX: -t=3600
#FLUX: --urgency=16

export DATADIR='/scratch/dac/data'
export TORCH_HOME='/scratch/dac/mvsjober/torch-cache'

module purge
module load pytorch/1.8
export DATADIR=/scratch/dac/data
export TORCH_HOME=/scratch/dac/mvsjober/torch-cache
set -xv
python3 $*
